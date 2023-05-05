import 'package:exam_app/components/social_security_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SsnInputDialog extends StatelessWidget {
  const SsnInputDialog({super.key});
  // Key for the form
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      // title: Text('Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.text_fields,
                  size: 84,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Indtast CPR-nummer",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Text("Indtast CPR-nummeret på patientens armbånd"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              autofocus: true,
              // Set format to only allow the formation of a CPR number 111111-1111
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter(RegExp(r'^[0-9-]*$'), allow: true),
                SocialSecurityInputFormat(),
              ],
              decoration: InputDecoration(
                labelText: "CPR-nummer",
                labelStyle: Theme.of(context).textTheme.labelLarge,
                hintText: "Indtast CPR-nummer",
                hintStyle: Theme.of(context).textTheme.labelLarge,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Indtast CPR-nummer";
                }
                return null;
              },
              onSaved: (value) {
                Navigator.pop(context, value);
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            // Set foreground color to error color
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Annuller"),
        ),
        TextButton(
          style: TextButton.styleFrom(
            // Set foreground color to on background color
            foregroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            }
          },
          child: const Text("Enter"),
        ),
      ],
    );
  }
}
