import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/login_registration_provider/registration_provider.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';

import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:crayon_management/widgets/error_text.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _verificationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final RegistrationProvider registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    final ErrorProvider errorProvider =
        Provider.of<ErrorProvider>(context, listen: false);
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
                    appTranslation!.translate('registration') ?? 'Registration',
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
                      validator: (email) =>
                          ValidatorService.checkEmail(email, appTranslation),
                      onChanged: (String text) =>
                          registrationProvider.setEmail(text),
                      controller: _emailController,
                      icon: Icons.email,
                      labelText: appTranslation.translate('email') ?? 'Email',
                    ),
                    CustomTextFormField(
                        isPassword: false,
                        validator: (text) =>
                            ValidatorService.isStringLengthAbove2(
                                text, appTranslation),
                        onChanged: (String text) =>
                            registrationProvider.setFirstName(text),
                        controller: _firstNameController,
                        icon: Icons.person,
                        labelText: appTranslation.translate('firstName') ??
                            'Firstname'),
                    CustomTextFormField(
                        isPassword: false,
                        validator: (text) =>
                            ValidatorService.isStringLengthAbove2(
                                text, appTranslation),
                        onChanged: (String text) =>
                            registrationProvider.setLastName(text),
                        controller: _lastNameController,
                        icon: Icons.person,
                        labelText: appTranslation.translate('lastName') ??
                            'Last name'),
                    CustomTextFormField(
                        isPassword: true,
                        validator: (password) => ValidatorService.checkPassword(
                            password, appTranslation),
                        onChanged: (String text) =>
                            registrationProvider.setPassword(text),
                        controller: _passwordController,
                        icon: Icons.password,
                        labelText:
                            appTranslation.translate('password') ?? 'Password'),
                    CustomTextFormField(
                        isPassword: true,
                        validator: (verificationPassword) =>
                            ValidatorService.checkVerificationPassword(
                                _passwordController.text,
                                verificationPassword,
                                appTranslation),
                        onChanged: (String text) =>
                            registrationProvider.setVerificationPassword(text),
                        controller: _verificationPasswordController,
                        icon: Icons.password,
                        labelText:
                            appTranslation.translate('password') ?? 'Password'),
                    Consumer<RegistrationProvider>(
                        builder: (context, regiProv, child) {
                      if (regiProv.state == LoadingState.no) {
                        return ElevatedButton.icon(
                            icon: const Icon(Icons.login),
                            label: Text(appTranslation.translate('register') ??
                                'Register'),
                            style: TextButton.styleFrom(
                                backgroundColor: regiProv.getColor(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 14.0)),
                            onPressed: () => regiProv.changIsLoading(
                                context, errorProvider));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                    Consumer<ErrorProvider>(
                        builder: (context, errorProv, child) {
                      if (errorProv.state == ErrorState.noError) {
                        return Container();
                      } else {
                        return ErrorText(error: errorProv.errorText);
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
