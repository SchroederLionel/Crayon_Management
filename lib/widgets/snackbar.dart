import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  String text;
  Color color;
  CustomSnackbar({required this.text, required this.color})
      : super(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: color);
}
