import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/screens/presentation/presentation_screen.dart';
import 'package:flutter/material.dart';

import 'package:crayon_management/screens/login_registration/login.dart';
import 'package:crayon_management/screens/dashboard/dashboard.dart';

/// Route Names
const String loginScreen = 'login';

const String dashboard = 'dashboard';
const String presentation = 'presentation';

/// Routes of the application.
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case dashboard:
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case presentation:
      return MaterialPageRoute(
          builder: (context) => PresentationScreen(
                lecture: routerSettings.arguments as Lecture,
              ));
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
