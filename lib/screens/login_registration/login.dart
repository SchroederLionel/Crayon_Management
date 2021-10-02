import 'package:crayon_management/providers/theme_provider.dart';
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
                children: [
                  const LanguageWidget(),
                  IconButton(
                      onPressed: () => themeProvider.swapTheme(),
                      icon: const Icon(
                        Icons.brightness_6,
                        color: Colors.black,
                      )),
                  Spacer(),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14.0)),
                      onPressed: () {
                        cardKey.currentState!.toggleCard();
                      },
                      child: Text('SignUp'))
                ],
              ),
              Expanded(
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  direction: FlipDirection.HORIZONTAL,
                  front: SignIn(),
                  back: SignUp(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// AppLocalizations.of(context)!.helloWorld