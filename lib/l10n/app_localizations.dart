import 'dart:async';
import 'dart:convert';
import 'package:crayon_management/datamodels/custom_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale appLocale;

  static final List<CustomLocale> languages = [
    CustomLocale(languageCode: 'en'),
    CustomLocale(languageCode: 'fr'),
    CustomLocale(languageCode: 'de'),
  ];
  Map<String, String>? _localizedStrings;

  AppLocalizations({required this.appLocale});

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    // Load JSON file from the "language" folder
    String jsonString = await rootBundle
        .loadString('assets/language/${appLocale.languageCode}.json');
    Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);

    _localizedStrings = jsonLanguageMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // called from every widget which needs a localized text
  String? translate(String jsonkey) {
    return _localizedStrings![jsonkey];
  }
}
