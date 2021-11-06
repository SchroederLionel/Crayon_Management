import 'dart:async';

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/providers/login_registration_provider/login_button_provider.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';
import 'package:crayon_management/providers/util_providers/login_provider.dart';
import 'package:crayon_management/screens/login_registration/components/sign_in_button.dart';

import 'package:crayon_management/services/authentication.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final LoginButtonProvider buttonProvider =
        Provider.of<LoginButtonProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final LoginProvider loginNo =
        Provider.of<LoginProvider>(context, listen: false);
    return Center(
        child: SizedBox(
      height: 560,
      width: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                'Crayon Management',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/crayon.png',
                height: 140,
                width: 180,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextFormField(
                        validator: (email) =>
                            ValidatorService.checkEmail(email, context),
                        onChanged: (String email) =>
                            buttonProvider.setEmail(email),
                        controller: _emailController,
                        icon: Icons.email,
                        labelText: translation!.email,
                        isPassword: false),
                    CustomTextFormField(
                        validator: (password) =>
                            ValidatorService.checkPassword(password, context),
                        onChanged: (String password) =>
                            buttonProvider.setPassword(password),
                        controller: _passwordController,
                        icon: Icons.password,
                        labelText: translation.password,
                        isPassword: true),
                    Consumer<LoginButtonProvider>(
                        builder: (context, loginButton, child) =>
                            SignInButton(onPressed: () async {
                              if (loginButton.getIsValid) {
                                loginNo
                                    .signUserIn(buttonProvider.getEmail,
                                        buttonProvider.getPassword, context)
                                    .then((value) => value.fold(
                                            (failure) => null, (userData) {
                                          userProvider.setUserData(userData);
                                          Navigator.pushNamed(
                                              context, route.dashboard);
                                        }));
                              }
                            })),
                    Consumer<LoginProvider>(
                        builder: (context, loginNotifier, child) {
                      if (loginNotifier.state == NotifierState.initial) {
                        return Container();
                      } else if (loginNotifier.state == NotifierState.loading) {
                        return const CircularProgressIndicator();
                      } else if (loginNotifier.state == NotifierState.loaded) {
                        return loginNotifier.userData.fold(
                            (failure) => Column(
                                  children: [
                                    Text(failure.toString()),
                                  ],
                                ), (userData) {
                          userProvider.setUserData(userData);

                          return Container();
                        });
                      } else {
                        return Container();
                      }
                    }),
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
