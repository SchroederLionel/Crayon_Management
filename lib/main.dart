import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/l10n/app_localizations_delegate.dart';

import 'package:crayon_management/services/authentication.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:crayon_management/Custom_scroll_behavior.dart';
import 'package:crayon_management/providers/util_providers/locale_provider.dart';
import 'package:crayon_management/providers/util_providers/menu_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      initialRoute: isSignedIN() ? route.dashboard : route.loginScreen,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.languages,
    );
  }
}
