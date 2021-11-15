import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;

  ThemeData light = ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.blueAccent,
      iconTheme: const IconThemeData(color: Colors.black),
      dialogBackgroundColor: const Color(0xFFFEFEFE),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
      )),
      backgroundColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFEFEFE),
      canvasColor: Colors.white,
      cardColor: const Color(0xFFF2F2F2),
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          headline2: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.black54),
          subtitle1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent),
          bodyText1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          bodyText2: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          headline6: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          headline5: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 38,
              fontWeight: FontWeight.w400,
              color: Colors.black)));

  ThemeData dark = ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.blueAccent,
      dialogBackgroundColor: const Color(0xFF212332),
      iconTheme: const IconThemeData(color: Colors.white54),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
      )),
      backgroundColor: const Color(0xFF212332),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF212332),
      canvasColor: const Color(0xFF2A2D3E),
      cardColor: const Color(0xFF2A2D3E),
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white),
          headline2: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white54),
          subtitle1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent),
          bodyText1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          bodyText2: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white54),
          headline6: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white),
          headline5: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 38,
              fontWeight: FontWeight.w400,
              color: Colors.white)));

  ThemeProvider({required bool isDarkMode}) {
    _selectedTheme = isDarkMode ? dark : light;
  }

  ThemeData get getTheme => _selectedTheme;

  void swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedTheme = _selectedTheme == dark ? light : dark;
    prefs.setBool('themeDark', _selectedTheme == dark ? true : false);
    notifyListeners();
  }
}
