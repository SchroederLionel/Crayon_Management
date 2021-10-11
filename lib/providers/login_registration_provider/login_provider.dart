import 'package:flutter/material.dart';

class LoginProvider {
  late String _email;
  late String _password;

  setEmail(String email) => _email = email;
  setPassword(String password) => _password = password;

  String get getEmail => _email;
  String get getPassword => _password;
}
