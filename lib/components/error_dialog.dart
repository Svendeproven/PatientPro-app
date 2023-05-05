import 'package:flutter/material.dart';

/// Error dialog for displaying an error message, returns a bool when closed
///
/// [context] is the context of the widget
/// [errorMessage] is the error message to display
Future<bool?> showErrorDialog(BuildContext context, String errorMessage) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text('Error'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
