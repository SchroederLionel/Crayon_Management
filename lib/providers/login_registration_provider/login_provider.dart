import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class LoginProvider extends ChangeNotifier {
  LoadingState _state = LoadingState.no;
  LoadingState get state => _state;
  bool _isValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  String _email = '';
  String _password = '';
  UserData? userData;

  void setState(LoadingState state) {
    _state = state;
    notifyListeners();
  }

  void changeLoadingState(
      BuildContext context, ErrorProvider errorProvider) async {
    if (_isValid) {
      setState(LoadingState.yes);
      Either<Failure, UserData> response = await signUserIn(_email, _password);
      setState(LoadingState.no);
      response
          .fold((failure) => errorProvider.setErrorState(failure.toString()),
              (userData) {
        Navigator.pushNamed(context, 'dashboard', arguments: userData);
      });
    }
  }

  Future<Either<Failure, UserData>> signUserIn(
      String email, String password) async {
    return await Task(() => signInWithEmailPassword(email, password))
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

  Color getColor() => _isValid ? Colors.blueAccent : Colors.grey[500]!;
}
