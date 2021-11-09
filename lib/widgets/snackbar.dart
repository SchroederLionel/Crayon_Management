import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  final String text;
  final Color color;
  CustomSnackbar({Key? key, required this.text, required this.color})
      : super(
            key: key,
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: color);
}
