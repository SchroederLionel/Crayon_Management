import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/user/login_provider.dart';
import 'package:crayon_management/providers/user/registration_provider.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';

import 'package:crayon_management/providers/util_providers/theme_provider.dart';
import 'package:crayon_management/screens/login_registration/components/sign_in.dart';
import 'package:crayon_management/screens/login_registration/components/sign_up.dart';
import 'package:crayon_management/widgets/language_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const LanguageWidget(),
                      IconButton(
                          onPressed: () => themeProvider.swapTheme(),
                          icon: const Icon(
                            Icons.lightbulb,
                          )),
                    ],
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14.0)),
                      onPressed: () {
                        cardKey.currentState!.toggleCard();
                      },
                      child: Text(
                          AppLocalizations.of(context)!.translate('register') ??
                              'Register'))
                ],
              ),
              Expanded(
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  direction: FlipDirection.HORIZONTAL,
                  front: MultiProvider(
                    providers: [
                      ChangeNotifierProvider<LoginProvider>(
                          create: (_) => LoginProvider()),
                      ChangeNotifierProvider<ErrorProvider>(
                          create: (_) => ErrorProvider())
                    ],
                    child: const SignIn(),
                  ),
                  back: MultiProvider(
                    providers: [
                      ChangeNotifierProvider<RegistrationProvider>(
                          create: (context) => RegistrationProvider()),
                      ChangeNotifierProvider<ErrorProvider>(
                          create: (context) => ErrorProvider())
                    ],
                    child: SignUp(
                      cardKey: cardKey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
