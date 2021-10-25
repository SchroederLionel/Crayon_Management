import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get getLocal => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
