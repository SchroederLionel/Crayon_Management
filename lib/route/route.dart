import 'package:crayon_management/screens/settings.dart';
import 'package:flutter/material.dart';

import 'package:crayon_management/screens/login_registration/login.dart';
import 'package:crayon_management/screens/dashboard/dashboard.dart';
import 'package:crayon_management/screens/login_registration/registration.dart';

/// Route Names
const String loginScreen = 'login';
const String registration = 'registration';
const String dashboard = 'dashboard';
const String settings = 'settings';

/// Routes of the application.
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case registration:
      return MaterialPageRoute(
          builder: (context) => const RegistrationScreen());
    case dashboard:
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case settings:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
