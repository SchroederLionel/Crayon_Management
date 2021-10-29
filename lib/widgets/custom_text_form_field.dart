import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final IconData icon;
  final String labelText;
  final bool isPassword;

  const CustomTextFormField(
      {required this.validator,
      required this.onChanged,
      required this.controller,
      required this.icon,
      required this.labelText,
      required this.isPassword,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            prefix: Icon(
              icon,
              size: 18,
            ),
            border: const UnderlineInputBorder(),
            labelText: labelText),
      ),
    );
  }
}
