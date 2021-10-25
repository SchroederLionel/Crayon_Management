import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class RegistrationProvider extends ChangeNotifier {
  bool _isValid = false;
  bool isEmailValid = false;
  bool isFirstNameValid = false;
  bool isLastNameValid = false;
  bool isPasswordValid = false;
  bool isPasswordVerificationValid = false;

  late String _email;
  late String _firstName;
  late String _lastName;
  late String _password;
  late String _verificationPassword;

  setIsValid() {
    if (isEmailValid &&
        isFirstNameValid &&
        isLastNameValid &&
        isPasswordValid &&
        isPasswordVerificationValid) {
      if (_isValid == false) {
        _isValid = true;
        notifyListeners();
      }
    } else {
      if (_isValid == true) {
        _isValid = false;
        notifyListeners();
      }
    }
  }

  Color getColor() {
    if (_isValid) {
      return Colors.blueAccent;
    } else {
      return Colors.grey[500]!;
    }
  }

  setIsVerificationPasswordValid(bool validVerificationPassword) =>
      isPasswordVerificationValid = validVerificationPassword;

  setEmail(String email) {
    _email = email;
    if (isEmail(_email)) {
      isEmailValid = true;
    } else {
      isEmailValid = false;
    }
    setIsValid();
  }

  setFirstName(String firstName) {
    _firstName = firstName;
    if (!isByteLength(_firstName, 2)) {
      isFirstNameValid = false;
    } else {
      isFirstNameValid = true;
    }
    setIsValid();
  }

  setLastName(String lastName) {
    _lastName = lastName;
    if (!isByteLength(_lastName, 2)) {
      isLastNameValid = false;
    } else {
      isLastNameValid = true;
    }
    setIsValid();
  }

  setPassword(String password) {
    _password = password;
    if (_password.trim().isEmpty) {
      isPasswordValid = false;
    } else if (_password.trim().length < 8) {
      isPasswordValid = false;
    } else {
      isPasswordValid = true;
    }
    setIsValid();
  }

  setVerificationPassword(String verificationPassword) {
    _verificationPassword = verificationPassword;
    if (_verificationPassword.trim().isEmpty) {
      isPasswordVerificationValid = false;
    } else if (_verificationPassword.trim().length < 8) {
      isPasswordVerificationValid = false;
    } else if (_verificationPassword != _password) {
      isPasswordVerificationValid = false;
    } else {
      isPasswordVerificationValid = true;
    }

    setIsValid();
  }

  String get getEmail => _email;
  String get getFirstName => _firstName;
  String get getLastName => _lastName;

  String get getPassword => _password;
  String get getVerificationPassword => _verificationPassword;
  bool get getIsValid => _isValid;
}
