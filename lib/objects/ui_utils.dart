import 'package:flutter/material.dart';

class UIUtils {
  static AlertDialog createAlertDialog(BuildContext context, String title, String content, {List<Widget>? actions}) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }

  static void createErrorDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return createAlertDialog(context, 'Erreur', content, actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ]);
        });
  }

  static void createConfirmationDialog(BuildContext context, String content, Function() onConfirm) {
    showDialog(
        context: context,
        builder: (context) {
          return createAlertDialog(context, 'Confirmation', content, actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: const Text('Confirmer'),
            ),
          ]);
        });
  }
}
