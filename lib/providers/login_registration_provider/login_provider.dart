import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  String _email = '';
  String _password = '';

  setIsValid() {
    if (_isEmailValid && _isPasswordValid) {
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

  changIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get getIsloading => _isLoading;

  setEmail(String email) {
    _email = email;
    if (isEmail(_email)) {
      _isEmailValid = true;
    } else {
      _isEmailValid = false;
    }
    setIsValid();
  }

  setPassword(String password) {
    _password = password;
    if (_password.trim().isEmpty) {
      _isPasswordValid = false;
    } else if (_password.trim().length < 8) {
      _isPasswordValid = false;
    } else {
      _isPasswordValid = true;
    }
    setIsValid();
  }

  Color getColor() {
    if (_isValid) {
      return Colors.blueAccent;
    } else {
      return Colors.grey[500]!;
    }
  }

  String get getEmail => _email;
  String get getPassword => _password;
  bool get getIsValid => _isValid;
}
