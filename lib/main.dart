import 'package:crayon_management/Custom_scroll_behavior.dart';
import 'package:crayon_management/providers/locale_provider.dart';
import 'package:crayon_management/providers/login_registration_provider/login_provider.dart';
import 'package:crayon_management/providers/login_registration_provider/registration_provider.dart';
import 'package:crayon_management/providers/menu_provider.dart';
import 'package:crayon_management/providers/presentation_provider.dart';
import 'package:crayon_management/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:crayon_management/providers/theme_provider.dart';
import 'route/route.dart' as route;
import 'package:url_strategy/url_strategy.dart';

void main() {
  // Removes # from url.
  setPathUrlStrategy();
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
      ChangeNotifierProvider<LoginProvider>(
        create: (BuildContext context) => LoginProvider(),
      ),
      ChangeNotifierProvider<RegistrationProvider>(
        create: (BuildContext context) => RegistrationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
