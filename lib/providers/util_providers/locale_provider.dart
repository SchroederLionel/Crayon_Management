import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = AppLocalizations.languages.first;

  Locale get getLocal => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
