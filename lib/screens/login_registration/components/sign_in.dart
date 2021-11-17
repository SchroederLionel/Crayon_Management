import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/user/login_provider.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';
import 'package:crayon_management/screens/login_registration/components/custom_button.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:crayon_management/widgets/error_text.dart';
import 'package:crayon_management/widgets/reset_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var appTranslation = AppLocalizations.of(context);

    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

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
                            ValidatorService.checkEmail(email, appTranslation),
                        onChanged: (String email) =>
                            loginProvider.setEmail(email),
                        controller: _emailController,
                        icon: Icons.email,
                        labelText:
                            appTranslation!.translate('email') ?? 'Email',
                        isPassword: false),
                    CustomTextFormField(
                        validator: (password) => ValidatorService.checkPassword(
                            password, appTranslation),
                        onChanged: (String password) =>
                            loginProvider.setPassword(password),
                        controller: _passwordController,
                        icon: Icons.password,
                        labelText:
                            appTranslation.translate('password') ?? 'Password',
                        isPassword: true),
                    Consumer<LoginProvider>(
                        builder: (context, loginButton, child) =>
                            loginButton.state == LoadingState.no
                                ? CustomButton(
                                    icon: Icons.login,
                                    color: loginButton.getColor(),
                                    text: appTranslation.translate('signIn') ??
                                        'Sign In',
                                    onPressed: () =>
                                        loginButton.changeLoadingState(
                                            context, errorProvider))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ResetPasswordDailog();
                              }).then((value) {
                            if (value is bool) {
                              if (value) {
                                const snackBar = SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: Text(
                                      'Reset password send to your email',
                                      textAlign: TextAlign.center,
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else if (value is Failure) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(value.code));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                        child: const Text('Forgot password')),
                    Consumer<ErrorProvider>(
                        builder: (context, errorNotifier, child) {
                      if (errorNotifier.state == ErrorState.noError) {
                        return Container();
                      } else {
                        return ErrorText(error: errorNotifier.errorText);
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
