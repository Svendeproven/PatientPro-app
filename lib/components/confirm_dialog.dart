import 'package:flutter/material.dart';

/// Confirm dialog which returns a bool
///
/// [context] is the context of the widget
/// [title] is the title of the dialog
/// [content] is the content of the dialog
/// [confirmText] is the text of the confirm button
/// [cancelText] is the text of the cancel button
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  String confirmText = "Bekræft",
  String cancelText = "Annuller",
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(cancelText),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
