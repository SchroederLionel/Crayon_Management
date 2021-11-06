import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/providers/login_registration_provider/login_provider.dart';

import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';
import 'package:crayon_management/screens/login_registration/components/custom_button.dart';
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
    final LoginProvider buttonProvider =
        Provider.of<LoginProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final ErrorProvider errorProvider =
        Provider.of<ErrorProvider>(context, listen: false);
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
                    Consumer<LoginProvider>(
                        builder: (context, loginButton, child) =>
                            loginButton.state == LoadingState.no
                                ? CustomButton(
                                    icon: Icons.login,
                                    color: loginButton.getColor(),
                                    text: translation.signIn,
                                    onPressed: () => loginButton
                                            .changeLoadingState(context)
                                            .then((value) {
                                          if (value != null) {
                                            buttonProvider
                                                .setState(LoadingState.no);
                                            value.fold(
                                                (failure) =>
                                                    errorProvider.setErrorState(
                                                        failure.toString()),
                                                (userData) {
                                              userProvider
                                                  .setUserData(userData);
                                              Navigator.pushNamed(
                                                  context, route.dashboard);
                                            });
                                          }
                                        }))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                    Consumer<ErrorProvider>(
                        builder: (context, errorNotifier, child) {
                      if (errorNotifier.state == ErrorState.noError) {
                        return Container();
                      } else {
                        return Text(errorNotifier.errorText);
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
