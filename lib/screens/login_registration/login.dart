import 'package:crayon_management/providers/login_registration_provider/registration_provider.dart';
import 'package:crayon_management/providers/theme_provider.dart';
import 'package:crayon_management/screens/login_registration/components/sign_in.dart';
import 'package:crayon_management/screens/login_registration/components/sign_up.dart';
import 'package:crayon_management/widgets/language_widget.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    var translation = AppLocalizations.of(context);
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
                      const LanguageWidget(
                        forStartingPage: true,
                      ),
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
                      child: Text(translation!.signUp))
                ],
              ),
              Expanded(
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  direction: FlipDirection.HORIZONTAL,
                  front: SignIn(),
                  back: Provider<RegistrationProvider>(
                    child: SignUp(
                      cardKey: cardKey,
                    ),
                    create: (context) => RegistrationProvider(),
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
