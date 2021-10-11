import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;
  static const hex_primary_color = 0xFF2A2D3E;
  ThemeData light = ThemeData(
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
      textTheme: TextTheme(
        headline1: GoogleFonts.lato(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline2: GoogleFonts.lato(
            fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black54),
        subtitle1: GoogleFonts.lato(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
        bodyText1: GoogleFonts.lato(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        bodyText2: GoogleFonts.lato(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),
      ));

  ThemeData dark = ThemeData(
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
      textTheme: TextTheme(
          headline1: GoogleFonts.lato(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: GoogleFonts.lato(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white60),
          subtitle1: GoogleFonts.lato(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
          bodyText1: GoogleFonts.lato(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),
          bodyText2: GoogleFonts.lato(
              fontSize: 18,
              color: Colors.white54,
              fontWeight: FontWeight.normal)));

  ThemeProvider({required bool isDarkMode}) {
    _selectedTheme = isDarkMode ? dark : light;
  }

  ThemeData get getTheme => _selectedTheme;

  void swapTheme() {
    _selectedTheme = _selectedTheme == dark ? light : dark;
    notifyListeners();
  }
}
