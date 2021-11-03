import 'package:crayon_management/providers/login_registration_provider/login_provider.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';

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
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Center(
        child: SizedBox(
      height: 500,
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
                height: 150,
                width: 190,
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
                            loginProvider.setEmail(email),
                        controller: _emailController,
                        icon: Icons.email,
                        labelText: translation!.email,
                        isPassword: false),
                    CustomTextFormField(
                        validator: (password) =>
                            ValidatorService.checkPassword(password, context),
                        onChanged: (String password) =>
                            loginProvider.setPassword(password),
                        controller: _passwordController,
                        icon: Icons.password,
                        labelText: translation.password,
                        isPassword: true),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      if (!loginProvider.getIsloading) {
                        return ElevatedButton.icon(
                            style: TextButton.styleFrom(
                                backgroundColor: loginProvider.getColor(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 14.0)),
                            onPressed: () async {
                              if (loginProvider.getIsValid) {
                                loginProvider.changIsLoading();
                                await signInWithEmailPassword(
                                        _emailController.text,
                                        _passwordController.text)
                                    .then((result) {
                                  if (result != null) {
                                    loginProvider.changIsLoading();
                                    userProvider.setUserData(result);
                                    Navigator.pushNamed(
                                        context, route.dashboard);
                                  } else {
                                    loginProvider.changIsLoading();
                                  }
                                }).catchError((error) {
                                  loginProvider.changIsLoading();
                                  print('Login Error: $error');
                                });
                              }
                            },
                            icon: const Icon(Icons.login),
                            label: Text(translation.signIn));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
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
