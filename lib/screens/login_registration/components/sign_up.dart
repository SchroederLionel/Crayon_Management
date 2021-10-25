import 'package:crayon_management/providers/login_registration_provider/registration_provider.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  final GlobalKey<FlipCardState> cardKey;
  const SignUp({required this.cardKey, Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _passwordController;
  late TextEditingController _verificationPasswordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _firstNameController = TextEditingController(text: '');
    _lastNameController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _verificationPasswordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _verificationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final RegistrationProvider registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    return Center(
        child: SizedBox(
      height: 530,
      width: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translation!.registration,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                      onPressed: () =>
                          widget.cardKey.currentState!.toggleCard(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 24,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextFormField(
                        isPassword: false,
                        validator: (val) {
                          if (!isEmail(val!)) {
                            return translation.invalidEmail;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String text) =>
                            registrationProvider.setEmail(text),
                        controller: _emailController,
                        icon: Icons.email,
                        labelText: translation.email),
                    CustomTextFormField(
                        isPassword: false,
                        validator: (val) {
                          if (!isByteLength(val!, 2)) {
                            return translation.firstNameEmpty;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String text) =>
                            registrationProvider.setFirstName(text),
                        controller: _firstNameController,
                        icon: Icons.person,
                        labelText: translation.firstName),
                    CustomTextFormField(
                        isPassword: false,
                        validator: (val) {
                          if (!isByteLength(val!, 2)) {
                            return translation.firstNameEmpty;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String text) =>
                            registrationProvider.setLastName(text),
                        controller: _lastNameController,
                        icon: Icons.person,
                        labelText: translation.lastName),
                    CustomTextFormField(
                        isPassword: true,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return translation.required;
                          }
                          if (value.trim().length < 8) {
                            return translation.passwordCheck;
                          }
                          // Return null if the entered password is valid

                          return null;
                        },
                        onChanged: (String text) =>
                            registrationProvider.setPassword(text),
                        controller: _passwordController,
                        icon: Icons.password,
                        labelText: translation.password),
                    CustomTextFormField(
                        isPassword: true,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return translation.required;
                          }
                          if (value.trim().length < 8) {
                            return translation.passwordCheck;
                          }
                          if (_verificationPasswordController.text !=
                              _passwordController.text) {
                            return translation.passwordMatch;
                          }

                          // Return null if the entered password is valid
                          return null;
                        },
                        onChanged: (String text) =>
                            registrationProvider.setVerificationPassword(text),
                        controller: _verificationPasswordController,
                        icon: Icons.password,
                        labelText: translation.password),
                    Consumer<RegistrationProvider>(
                        builder: (context, regiProv, child) =>
                            ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        registrationProvider.getColor(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0, vertical: 14.0)),
                                onPressed: () async {
                                  if (regiProv.getIsValid) {
                                    await registerWithEmailPassword(
                                      _emailController.text,
                                      registrationProvider.getPassword,
                                      _firstNameController.text,
                                      _lastNameController.text,
                                    ).then((result) {
                                      if (result != null) {
                                        widget.cardKey.currentState!
                                            .toggleCard();
                                        final snackBar = SnackBar(
                                            content:
                                                const Text('Account created!'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        final snackBar = SnackBar(
                                            content: const Text(
                                                'Account alreadExists!'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }).catchError((error) {
                                      print(error);
                                      print('error while registrting');
                                    });
                                  }
                                },
                                icon: const Icon(Icons.login),
                                label: Text(translation.register)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
