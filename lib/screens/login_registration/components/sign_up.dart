import 'package:crayon_management/providers/login_registration_provider/registration_provider.dart';
import 'package:crayon_management/services/authentication.dart';
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
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        validator: (val) =>
                            !isEmail(val!) ? translation.invalidEmail : null,
                        controller: _emailController,
                        onChanged: (String text) =>
                            registrationProvider.setEmail(text),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: translation.email),
                      ),
                      TextFormField(
                        validator: (val) => !isByteLength(val!, 2)
                            ? translation.firstNameEmpty
                            : null,
                        onChanged: (String text) =>
                            registrationProvider.setFirstName(text),
                        controller: _firstNameController,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: translation.firstName),
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        validator: (val) => !isByteLength(val!, 2)
                            ? translation.lastNameEmpty
                            : null,
                        onChanged: (String text) =>
                            registrationProvider.setLastName(text),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: translation.lastName),
                      ),
                      TextFormField(
                          controller: _passwordController,
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
                          style: Theme.of(context).textTheme.bodyText1,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                size: 18,
                              ),
                              border: UnderlineInputBorder(),
                              labelText: translation.password)),
                      TextFormField(
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

                            return null;
                          },
                          controller: _verificationPasswordController,
                          onChanged: (String text) => registrationProvider
                              .setVerificationPassword(text),
                          style: Theme.of(context).textTheme.bodyText1,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.password,
                                size: 18,
                              ),
                              border: const UnderlineInputBorder(),
                              labelText: translation.password)),
                      ElevatedButton.icon(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 14.0)),
                          onPressed: () async {
                            await registerWithEmailPassword(
                              _emailController.text,
                              registrationProvider.getPassword,
                              _firstNameController.text,
                              _lastNameController.text,
                            ).then((result) {
                              if (result != null) {
                                widget.cardKey.currentState!.toggleCard();
                                final snackBar = SnackBar(
                                    content: const Text('Account created!'),
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
                                    content:
                                        const Text('Account alreadExists!'),
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
                          },
                          icon: Icon(Icons.login),
                          label: Text(translation.register))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class RegistrationFields extends StatelessWidget {
  const RegistrationFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                size: 18,
              ),
              border: UnderlineInputBorder(),
              labelText: translation!.email),
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                size: 18,
              ),
              border: UnderlineInputBorder(),
              labelText: translation.firstName),
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                size: 18,
              ),
              border: UnderlineInputBorder(),
              labelText: translation.lastName),
        ),
        TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  size: 18,
                ),
                border: UnderlineInputBorder(),
                labelText: translation.password)),
        TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  size: 18,
                ),
                border: UnderlineInputBorder(),
                labelText: translation.password)),
      ],
    );
  }
}
