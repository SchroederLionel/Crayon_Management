import 'package:crayon_management/datamodels/custom_locale.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = AppLocalizations.languages.first;

  LocaleProvider(String? code) {
    if (code == null) {
      _locale = AppLocalizations.languages.first;
    } else {
      _locale = CustomLocale(languageCode: code);
    }
  }

  Locale get getLocal => _locale;

  void setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = locale;
    prefs.setString('language', _locale.languageCode);
    notifyListeners();
  }
}
