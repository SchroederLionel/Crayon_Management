import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class ValidatorService {
  static String? checkEmail(String? email, AppLocalizations? appLo) {
    if (email != null) {
      if (!isEmail(email)) {
        return appLo!.translate('invalidEmail') ?? 'Invalid Email';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }
    return null;
  }

  static String? checkPassword(String? password, AppLocalizations? appLo) {
    if (password != null) {
      if (password.trim().isEmpty) {
        return appLo!.translate('required') ?? 'Required';
      }
      if (password.trim().length < 8) {
        return appLo!.translate('passwordCheck') ?? 'passwordCheck';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }
    return null;
  }

  static String? checkVerificationPassword(
      String? password, String? verificationPassword, AppLocalizations? appLo) {
    if (password != null && verificationPassword != null) {
      if (verificationPassword.trim().isEmpty) {
        return appLo!.translate('required') ?? 'Required';
      }
      if (verificationPassword.trim().length < 8) {
        return appLo!.translate('passwordCheck') ??
            'Passwords length us below 8.';
      }
      if (verificationPassword != password) {
        return appLo!.translate('passwordMatch') ?? 'Passwords do not match';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }
    return null;
  }

  static String? isStringLengthAbove2(String? text, AppLocalizations? appLo) {
    if (text != null) {
      if (!isByteLength(text, 2)) {
        return appLo!.translate('required') ?? 'Required';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }

    return null;
  }

  static String? isNumber(String? text, BuildContext context) {
    if (text != null) {
      if (isInt(text)) {
        return 'Number required';
      }
    }
    return null;
  }
}
