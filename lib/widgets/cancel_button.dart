import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.grey[500]),
        onPressed: () => Navigator.pop(context, false),
        child: Text(appTranslation!.translate('cancel') ?? 'Cancel'));
  }
}
