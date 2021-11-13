import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class RegistrationProvider extends ChangeNotifier {
  LoadingState _state = LoadingState.no;
  LoadingState get state => _state;

  void setState(LoadingState state) {
    _state = state;
    notifyListeners();
  }

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

  void changIsLoading(BuildContext context, ErrorProvider errorProvider) async {
    if (_isValid) {
      setState(LoadingState.yes);
      Either<Failure, UserData> response = await register();
      setState(LoadingState.no);
      response.fold(
          (failure) => errorProvider.setErrorState(failure.toString()),
          (userData) =>
              Navigator.pushNamed(context, 'dashboard', arguments: userData));
      notifyListeners();
    }
  }

  Future<Either<Failure, UserData>> register() async {
    return await Task(() =>
            registerWithEmailPassword(_email, _password, _firstName, _lastName))
        .attempt()
        .map(
          (either) => either.leftMap((obj) {
            try {
              return obj as Failure;
            } catch (e) {
              throw obj;
            }
          }),
        )
        .run();
  }

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

  Color getColor() => _isValid ? Colors.blueAccent : Colors.grey[500]!;

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
