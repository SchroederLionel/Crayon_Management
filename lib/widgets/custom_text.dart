import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// The customtext widget allows to use the Textwidget with the additional feature of translation.
class CustomText extends StatelessWidget {
  final TextStyle? style;

  /// Textcode for translation.
  final String? textCode;

  /// If the textCode is null or the transaltion of the text code is null the saftytext will be used.
  final String safetyText;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  /// Additional is used if another string needs to be attached after the text. (I.E Room + additional = Room L12.)
  final String? additional;

  const CustomText(
      {Key? key,
      this.textCode,
      this.additional,
      required this.safetyText,
      this.style,
      this.textAlign,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    String? text;
    if (textCode == null) {
      text = safetyText;
    } else {
      text = appTranslation!.translate(textCode as String);
    }
    if (additional != null) {
      text = '$text $additional';
    }
    return Text(
      text ?? safetyText,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
