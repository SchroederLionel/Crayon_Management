import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final String text;
  const CustomButton(
      {required this.icon,
      required this.text,
      required this.color,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: TextButton.styleFrom(
          backgroundColor: color,
          padding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0)),
    );
  }
}
