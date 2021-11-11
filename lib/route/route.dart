import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/presentation/current_pdf_provider.dart';
import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/presentation/show_options_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/detailed_lecture_screen.dart';
import 'package:crayon_management/screens/presentation/presentation_screen.dart';
import 'package:flutter/material.dart';

import 'package:crayon_management/screens/login_registration/login.dart';
import 'package:crayon_management/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

/// Route Names
const String loginScreen = 'login';
const String dashboard = 'dashboard';
const String detailedLecture = 'detailedLecture';
const String presentation = 'presentation';

/// Routes of the application.
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case dashboard:
      return MaterialPageRoute(
          builder: (context) =>
              Dashboard(userData: routerSettings.arguments as UserData));
    case detailedLecture:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<DetailedLectureProvider>(
                        create: (context) => DetailedLectureProvider()),
                    ChangeNotifierProvider<QuizProvider>(
                        create: (context) => QuizProvider())
                  ],
                  child: DetailedLectureScreen(
                    lecture: routerSettings.arguments as LectureSnipped,
                  )));
    case presentation:
      var arg = routerSettings.arguments as PresentationScreenArgument;
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<PresentationProvider>(
                      create: (context) => PresentationProvider()),
                  ChangeNotifierProvider<PageCountProvider>(
                      create: (context) => PageCountProvider()),
                  Provider<CurrentPdfProvider>(
                      create: (context) => CurrentPdfProvider()),
                  ChangeNotifierProvider<QuizSelectorProvider>(
                      create: (context) =>
                          QuizSelectorProvider(quizes: arg.quizes)),
                  ChangeNotifierProvider<ShowOptionProvider>(
                      create: (context) => ShowOptionProvider())
                ],
                child: Material(
                  color: const Color(0xFF212332),
                  child: PresentationScreen(
                    arg: arg,
                  ),
                ),
              ));

    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
