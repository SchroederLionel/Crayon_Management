import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:crayon_management/route/route.dart' as route;

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, route.loginScreen),
              icon: const Icon(Icons.airline_seat_individual_suite_sharp,
                  color: Colors.amber)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, route.loginScreen),
          child: Text(AppLocalizations.of(context)!.helloWorld),
        ),
      ),
    );
  }
}
