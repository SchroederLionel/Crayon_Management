import 'dart:io';

import 'package:crayon_management/providers/theme_provider.dart';
import 'package:crayon_management/widgets/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crayon_management/route/route.dart' as route;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        actions: [
          const LanguageWidget(),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, route.registration),
              icon: const Icon(Icons.airline_seat_individual_suite_sharp,
                  color: Colors.amber)),
          IconButton(
              onPressed: () => themeProvider.swapTheme(),
              icon: const Icon(
                Icons.brightness_6,
                color: Colors.black,
              ))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.helloWorld),
          ],
        ),
      ),
    );
  }
}
