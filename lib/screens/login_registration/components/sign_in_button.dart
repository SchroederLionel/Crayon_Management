import 'package:crayon_management/providers/login_registration_provider/login_button_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SignInButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final LoginButtonProvider buttonProvider =
        Provider.of<LoginButtonProvider>(context, listen: false);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.login),
      label: Text(translation!.signIn),
      style: TextButton.styleFrom(
          backgroundColor: buttonProvider.getColor(),
          padding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0)),
    );
  }
}
