import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  late UserData currentUserdata;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _personalRoomController;
  late TextEditingController _phoneNumerController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newVerificationPasswordController;

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    currentUserdata = userProvider.getUserData;
    _firstNameController =
        TextEditingController(text: userProvider.getFirstName);
    _lastNameController = TextEditingController(text: userProvider.getLastName);
    _emailController = TextEditingController(text: userProvider.getEmail);
    _personalRoomController =
        TextEditingController(text: userProvider.getOffice);
    _phoneNumerController =
        TextEditingController(text: userProvider.getPhoneNumber);

    _newPasswordController = TextEditingController();
    _newVerificationPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _personalRoomController.dispose();
    _phoneNumerController.dispose();
    _newPasswordController.dispose();
    _newVerificationPasswordController.dispose();
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
                        onPressed: () {
                          UserData newUserData = UserData(
                              uid: currentUserdata.uid,
                              email: _emailController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              myLectures: currentUserdata.myLectures,
                              office: _personalRoomController.text.isEmpty
                                  ? null
                                  : _personalRoomController.text,
                              phoneNumber: _phoneNumerController.text.isEmpty
                                  ? null
                                  : _phoneNumerController.text);

                          if (newUserData == currentUserdata) {
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
