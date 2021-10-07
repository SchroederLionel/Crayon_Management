import 'package:flutter/cupertino.dart';

class RegistrationProvider extends ChangeNotifier {
  late String _email;
  late String _firstName;
  late String _lastName;
  late String _password;
  late String _verificationPassword;

  setEmail(String email) => _email = email;
  setFirstName(String firstName) => _firstName = firstName;
  setLastName(String lastName) => _lastName = lastName;

  setPassword(String password) => _password = password;
  setVerificationPassword(String verificationPassword) =>
      _verificationPassword = verificationPassword;

  String get getEmail => _email;
  String get getFirstName => _firstName;
  String get getLastName => _lastName;

  String get getPassword => _password;
  String get getVerificationPassword => _verificationPassword;
}
