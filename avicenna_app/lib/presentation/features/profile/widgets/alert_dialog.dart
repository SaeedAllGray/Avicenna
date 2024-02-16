import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({super.key, required this.onConfirmPressed});

  final VoidCallback onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(Icons.warning),
      content: Text(AppLocalizations.of(context)!.areYouSure),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.no),
        ),
        TextButton(
          onPressed: () {
            onConfirmPressed();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.yes),
        ),
      ],
    );
  }
}
