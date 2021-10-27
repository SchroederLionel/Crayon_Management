import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:crayon_management/Custom_scroll_behavior.dart';
import 'package:crayon_management/providers/util_providers/locale_provider.dart';
import 'package:crayon_management/providers/util_providers/menu_provider.dart';
import 'package:crayon_management/providers/presentation_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:crayon_management/providers/util_providers/theme_provider.dart';
import 'route/route.dart' as route;

void main() async {
  // Removes # from url.
  // setPathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize Firebase

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MenuProvider>(create: (context) => MenuProvider()),
      ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) => ThemeProvider(isDarkMode: true),
      ),
      ChangeNotifierProvider<LocaleProvider>(
        create: (BuildContext context) => LocaleProvider(),
      ),
      ChangeNotifierProvider<PresentationProvider>(
        create: (BuildContext context) => PresentationProvider(),
      ),
      ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) => UserProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initilaization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);
  //var app = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: true);

    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Crayon Management',
      theme: themeProvider.getTheme,
      locale: localeProvider.getLocal,
      onGenerateRoute: route.controller,
      initialRoute: route.loginScreen,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
