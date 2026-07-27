import 'package:flutter/material.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';

void showConfirmation(BuildContext context, String descText, Function onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Action"),
        content: Text(descText), 
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              onPressed();
              Navigator.pop(context);
            },
            child: Text(context.l10n.confirm),
          ),
        ],
      );
    },
  );
}