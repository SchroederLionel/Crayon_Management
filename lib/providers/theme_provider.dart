import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;

  ThemeData light = ThemeData.light().copyWith(
      primaryColor: const Color(0xFF212332),
      textTheme: TextTheme(
        headline1:
            GoogleFonts.poppins(fontSize: 72.0, fontWeight: FontWeight.bold),
      ));

  ThemeData dark = ThemeData(
      backgroundColor: const Color(0xFF212332),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF212332),
      canvasColor: const Color(0xFF2A2D3E),
      cardColor: const Color(0xFF2A2D3E),
      textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              color: Colors.white54),
          subtitle1: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.w100,
              color: Colors.white54)));

  ThemeProvider({required bool isDarkMode}) {
    _selectedTheme = isDarkMode ? dark : light;
  }

  ThemeData get getTheme => _selectedTheme;

  void swapTheme() {
    _selectedTheme = _selectedTheme == dark ? light : dark;
    notifyListeners();
  }
}
