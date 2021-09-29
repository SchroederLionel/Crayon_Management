import 'package:crayon_management/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:crayon_management/providers/theme_provider.dart';
import 'route/route.dart' as route;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) => ThemeProvider(isDarkMode: true),
      ),
      ChangeNotifierProvider<LocaleProvider>(
        create: (BuildContext context) => LocaleProvider(),
      )
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
