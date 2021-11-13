import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatefulWidget {
  final UserData userData;
  const ProfileDialog({required this.userData, Key? key}) : super(key: key);

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  late UserData userData;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _personalRoomController;
  late TextEditingController _phoneNumerController;

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
    _firstNameController = TextEditingController(text: userData.firstName);
    _lastNameController = TextEditingController(text: userData.lastName);
    _emailController = TextEditingController(text: userData.email);
    _personalRoomController =
        TextEditingController(text: userData.office ?? '');
    _phoneNumerController =
        TextEditingController(text: userData.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _personalRoomController.dispose();
    _phoneNumerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
          width: 550,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appTranslation!.translate('profile') ?? 'Profile',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ))
                  ],
                ),
                const SizedBox(height: 14),
                CustomTextFormField(
                    validator: (text) => ValidatorService.isStringLengthAbove2(
                        text, appTranslation),
                    onChanged: (String text) => () {},
                    controller: _firstNameController,
                    icon: Icons.person,
                    labelText:
                        appTranslation.translate('firstName') ?? 'First name',
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) => ValidatorService.isStringLengthAbove2(
                        text, appTranslation),
                    onChanged: (String text) => () {},
                    controller: _lastNameController,
                    icon: Icons.person,
                    labelText:
                        appTranslation.translate('lastName') ?? 'Last name',
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) => ValidatorService.isStringLengthAbove2(
                        text, appTranslation),
                    onChanged: (String text) => () {},
                    controller: _emailController,
                    icon: Icons.person,
                    labelText: appTranslation.translate('email') ?? 'Email',
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) => ValidatorService.isStringLengthAbove2(
                        text, appTranslation),
                    onChanged: (String text) => () {},
                    controller: _personalRoomController,
                    icon: Icons.room,
                    labelText: appTranslation.translate('room') ?? 'Room',
                    isPassword: false),
                CustomTextFormField(
                    validator: (text) => ValidatorService.isStringLengthAbove2(
                        text, appTranslation),
                    onChanged: (String text) => () {},
                    controller: _phoneNumerController,
                    icon: Icons.phone,
                    labelText: appTranslation.translate('phoneNumber') ??
                        'Phone number',
                    isPassword: false),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          UserData newUserData = UserData(
                              uid: userData.uid,
                              email: _emailController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              office: _personalRoomController.text.isEmpty
                                  ? null
                                  : _personalRoomController.text,
                              phoneNumber: _phoneNumerController.text.isEmpty
                                  ? null
                                  : _phoneNumerController.text);
                          newUserData.setmyLectures(userData.myLectures);
                          if (newUserData == userData) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context, newUserData);
                          }
                        },
                        child: Text(
                          appTranslation.translate('upload') ?? 'Upload',
                        ))
                  ],
                ),
                Container(
                    height: 25,
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 3.0,
                              color: Theme.of(context).primaryColor)),
                    )),
              ],
            ),
          )),
    );
  }
}
