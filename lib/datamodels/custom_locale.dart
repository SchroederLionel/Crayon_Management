import 'package:flutter/material.dart';

class CustomLocale extends Locale {
  @override
  String languageCode;

  CustomLocale({required this.languageCode}) : super(languageCode);

  @override
  int get hashCode => languageCode.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomLocale && other.languageCode == languageCode;
  }
}
