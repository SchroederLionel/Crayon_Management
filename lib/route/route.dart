import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/datamodels/route_arguments/quiz_launch.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/quiz/lobby_provider.dart';
import 'package:crayon_management/providers/quiz/user_responses_provider.dart';
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

import 'package:crayon_management/screens/presentation/presentation_screen.dart';
import 'package:crayon_management/screens/quiz/quiz_screen.dart';

import 'package:flutter/material.dart';

import 'package:crayon_management/screens/login_registration/login.dart';
import 'package:crayon_management/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

/// Route Names
const String loginScreen = '/login';
const String dashboard = '/dashboard';
const String detailedLecture = '/dashboard/lecture';
const String presentation = '/dashboard/lecture/presentation';
const String quiz = '/dashboard/lecture/quiz';

/// Routes of the application.
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case loginScreen:
      return MaterialPageRoute(
          settings: const RouteSettings(name: ''),
          builder: (context) => const LoginScreen());
    case dashboard:
      return MaterialPageRoute(
          settings: const RouteSettings(name: 'dashboard'),
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
      LectureSnipped snipped = routerSettings.arguments as LectureSnipped;
      return MaterialPageRoute(
          settings: RouteSettings(
              name: 'dashboard/lecture/${snipped.title.replaceAll(' ', '')}'),
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<DetailedLectureProvider>(
                        create: (context) => DetailedLectureProvider()),
                    ChangeNotifierProvider<QuizProvider>(
                        create: (context) => QuizProvider())
                  ],
                  child: DetailedLectureScreen(
                    lecture: snipped,
                  )));
    case presentation:
      var arg = routerSettings.arguments as PresentationScreenArgument;
      return MaterialPageRoute(
          settings: RouteSettings(
              name:
                  '/lecture/${arg.lecture.title.replaceAll(' ', '')}/presentation'),
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<PresentationProvider>(
                      create: (context) => PresentationProvider()),
                  ChangeNotifierProvider<PageCountProvider>(
                      create: (context) => PageCountProvider()),
                  Provider<CurrentPdfProvider>(
                      create: (context) => CurrentPdfProvider()),
                  ChangeNotifierProvider<QuizSelectorProvider>(
                      create: (context) => QuizSelectorProvider(
                          quizes: arg.quizes, lectureId: arg.lecture.id)),
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
          settings: RouteSettings(
              name: '/lecture/${arg.lecture.title.replaceAll(' ', '')}/quiz'),
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<UserResponsesProvider>(
                        create: (context) => UserResponsesProvider()),
                    ChangeNotifierProvider<QuizSelectorProvider>(
                        create: (context) => QuizSelectorProvider(
                            quizes: arg.quizes, lectureId: arg.lecture.id)),
                    ChangeNotifierProvider<LobbyProvider>(
                        create: (context) =>
                            LobbyProvider(lectureId: arg.lecture.id))
                  ],
                  child: QuizScreen(
                    lecture: arg.lecture,
                  )));
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
