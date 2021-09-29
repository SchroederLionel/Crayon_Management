import 'package:flutter/material.dart';

import 'package:crayon_management/screens/login_registration/login.dart';
import 'package:crayon_management/screens/login_registration/registration.dart';

/// Route Names
const String loginScreen = 'login';
const String registration = 'registration';

/// Routes of the application.
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case registration:
      return MaterialPageRoute(
          builder: (context) => const RegistrationScreen());
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
