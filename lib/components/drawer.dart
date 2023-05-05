import 'package:exam_app/components/drawer_link.dart';
import 'package:exam_app/components/error_dialog.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ExamDrawer is a widget which is used to display the drawer in the app
class ExamDrawer extends StatelessWidget {
  const ExamDrawer({super.key});

  /// override build method
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child:
            // Consumer to get the user from the UserViewModel
            Consumer<UserViewModel>(builder: (context, userViewModel, child) {
          if (userViewModel.user == null) {
            return Container();
          }
          return Column(
            children: [
              Card(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.person),
                    ),
                    Text(
                      userViewModel.user!.name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Drawer links
              drawerLink(context, "Forside", "/", Icons.home),
              drawerLink(
                  context, "Afdeling", "/department", Icons.location_city),
              drawerLink(context, "Medicin", "/medicine", Icons.medication),
              drawerLink(context, "Patient håndtering", "/scan", Icons.sick),
              drawerLink(context, "Kroppen", "/holograms", Icons.accessibility),

              // Spacer
              const Expanded(child: SizedBox()),

              // ElevatedButton for sign out
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    // Call sign out method
                    bool signedOut = await Auth.signOut(userViewModel.user!);

                    // Check if sign out was successful
                    if (signedOut) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false);
                    } else {
                      // Show error if sign out was not successful
                      // ignore: use_build_context_synchronously
                      showErrorDialog(context,
                          "Der skete en fejl ved log ud, prøv igen senere");
                    }
                  },
                  child: const Text("Log ud"),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
