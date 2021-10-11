import 'package:flutter/material.dart';

class L10n {
  static final languages = [
    const Locale('en'),
    const Locale('fr'),
    const Locale('de'),
  ];
  static const defaultLanguage = 'en';
  static String getFlag(String code) {
    switch (code) {
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'en':
      default:
        return '🇺🇸';
    }
  }

  static String getText(String localeCode) {
    switch (localeCode) {
      case 'de':
        return 'german';
      case 'en':
        return 'english';
      case 'fr':
        return 'french';
      default:
        return 'english';
    }
  }
}
