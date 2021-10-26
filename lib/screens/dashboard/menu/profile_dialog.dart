import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              CustomTextFormField(
                  validator: validator,
                  onChanged: onChanged,
                  controller: _firstNameController,
                  icon: icon,
                  labelText: labelText,
                  isPassword: isPassword)
            ],
          )),
    );
  }
}
