import 'package:flutter/cupertino.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidatorService {
  static String? checkEmail(String? email, BuildContext context) {
    var translation = AppLocalizations.of(context);
    if (email != null) {
      if (!isEmail(email)) return translation!.invalidEmail;
    } else {
      return translation!.required;
    }
    return null;
  }

  static String? checkPassword(String? password, BuildContext context) {
    var translation = AppLocalizations.of(context);
    if (password != null) {
      if (password.trim().isEmpty) {
        return translation!.required;
      }
      if (password.trim().length < 8) {
        return translation!.passwordCheck;
      }
    } else {
      return translation!.required;
    }
    return null;
  }

  static String? checkVerificationPassword(
      String? password, String? verificationPassword, BuildContext context) {
    var translation = AppLocalizations.of(context);
    if (password != null && verificationPassword != null) {
      if (verificationPassword.trim().isEmpty) {
        return translation!.required;
      }
      if (verificationPassword.trim().length < 8) {
        return translation!.passwordCheck;
      }
      if (verificationPassword != password) {
        return translation!.passwordMatch;
      }
    } else {
      return translation!.required;
    }
    return null;
  }

  static String? isStringLengthAbove2(String? text, BuildContext context) {
    var translation = AppLocalizations.of(context);
    if (text != null) {
      if (!isByteLength(text, 2)) {
        return translation!.required;
      }
    } else {
      return translation!.required;
    }

    return null;
  }

  static String? isNumber(String? text, BuildContext context) {
    var translation = AppLocalizations.of(context);
    if (text != null) {
      if (isInt(text)) {
        return 'Number required';
      }
    }
    return null;
  }
}
