import 'package:exam_app/exceptions/unauthorized_exception.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';
import 'package:provider/provider.dart';

/// This is the login view
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // This is used to show the password
  bool _showPassword = false;

  // This is used to toggle the password visibility
  void _clickShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  // override build method
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "Svendeprøven",
                //   style: Theme.of(context).textTheme.displayLarge,
                // ),
                Image(
                    image: AssetImage(isDarkMode
                        ? "assets/images/logo-white-crop.png"
                        : "assets/images/logo-crop.png")),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: LoForm<String>(
                        submittableWhen: (status) => status.isValid,
                        onSubmit: (values, setErrors) async {
                          // Sign the user in
                          try {
                            var user = await Auth.signIn(
                                values.get("email"), values.get("password"));
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              Provider.of<UserViewModel>(context, listen: false)
                                  .setUser(user);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(context, "/");
                            }
                          } catch (e) {
                            if (e is UnauthorizedException) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Server fejl, prøv igen"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                          return true;
                        },
                        builder: (form) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 10, left: 20, right: 20),
                                child: LoTextField(
                                  loKey: "email",
                                  validators: [
                                    LoRequiredValidator("Email er påkrævet"),
                                    LoRegExpValidator.email(
                                        "Email er ikke gyldig"),
                                  ],
                                  props: TextFieldProps(
                                    textCapitalization: TextCapitalization.none,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xff3d4a64), width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: LoTextField(
                                  loKey: "password",
                                  validators: [
                                    LoRequiredValidator(
                                        "Adgangskode er påkrævet"),
                                    LoLengthValidator.min(8,
                                        "Adgangskoden skal være mindst 8 tegn langt")
                                  ],
                                  props: TextFieldProps(
                                    decoration: InputDecoration(
                                      hintText: "Adgangskode",
                                      hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xff3d4a64), width: 1),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(_showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: _clickShowPassword,
                                      ),
                                    ),
                                    obscureText: !_showPassword,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: form.submit,
                                    child: const Text("Login"),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
