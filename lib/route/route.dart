import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/datamodels/route_arguments/quiz_launch.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/quiz/lobby_provider.dart';
import 'package:crayon_management/providers/user/user_provider.dart';
import 'package:crayon_management/providers/presentation/current_pdf_provider.dart';
import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/presentation/show_options_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/providers/user/user_header_provider.dart';
import 'package:crayon_management/providers/user/user_lectures_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/detailed_lecture_screen.dart';
import 'package:crayon_management/screens/presentation/components/quiz/quiz_screen.dart';

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
const String quiz = 'quiz';

/// Routes of the application.
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case dashboard:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  Provider<UserProvider>(
                      create: (BuildContext context) => UserProvider()),
                  ChangeNotifierProvider<UserHeaderProvider>(
                      create: (BuildContext context) => UserHeaderProvider()),
                  ChangeNotifierProvider<UserLectureProvider>(
                      create: (BuildContext context) => UserLectureProvider())
                ],
                child: const Dashboard(),
              ));
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
                      create: (context) => ShowOptionProvider()),
                ],
                child: Material(
                  color: const Color(0xFF212332),
                  child: PresentationScreen(
                    arg: arg,
                  ),
                ),
              ));
    case quiz:
      var arg = routerSettings.arguments as QuizLaunchArguement;
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<QuizSelectorProvider>(
                        create: (context) =>
                            QuizSelectorProvider(quizes: arg.quizes)),
                    ChangeNotifierProvider<LobbyProvider>(
                        create: (context) =>
                            LobbyProvider(lectureId: arg.lectureId))
                  ],
                  child: QuizScreen(
                    lectureId: arg.lectureId,
                  )));
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
