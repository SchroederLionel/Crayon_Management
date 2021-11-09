import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({required this.error, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return Text(
      appTranslation!.translate(error) ?? error,
      style: const TextStyle(
          fontSize: 19,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: Colors.red),
    );
  }
}
