import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _personalRoomController;
  late TextEditingController _phoneNumerController;
  late TextEditingController _currentPassword;

  late TextEditingController _newPassword;
  late TextEditingController _newVerificationPassword;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _personalRoomController = TextEditingController();
    _phoneNumerController = TextEditingController();
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _newVerificationPassword = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _personalRoomController.dispose();
    _phoneNumerController.dispose();
    _currentPassword.dispose();
    _newPassword.dispose();
    _newVerificationPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black26)),
            onPressed: () => Navigator.pop(context),
            child: Text(translation!.cancel)),
        ElevatedButton(onPressed: () {}, child: Text(translation.upload))
      ],
      content: SizedBox(
          width: 550,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translation.profile,
                  style: Theme.of(context).textTheme.headline1,
                ),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _firstNameController,
                    icon: Icons.person,
                    labelText: translation.firstName,
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _lastNameController,
                    icon: Icons.person,
                    labelText: translation.lastName,
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _emailController,
                    icon: Icons.person,
                    labelText: translation.email,
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _personalRoomController,
                    icon: Icons.room,
                    labelText: translation.room,
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _phoneNumerController,
                    icon: Icons.room,
                    labelText: translation.phoneNumber,
                    isPassword: false),
                Container(
                    width: 250,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).primaryColor)),
                    )),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _currentPassword,
                    icon: Icons.password,
                    labelText: translation.currentPassword,
                    isPassword: true),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _newPassword,
                    icon: Icons.password,
                    labelText: translation.newPassword,
                    isPassword: true),
                CustomTextFormField(
                    validator: (text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String text) => () {},
                    controller: _newPassword,
                    icon: Icons.password,
                    labelText: translation.newVerificationPass,
                    isPassword: true),
              ],
            ),
          )),
    );
  }
}
