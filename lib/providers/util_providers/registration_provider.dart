import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<Failure, UserData> _userData;
  Either<Failure, UserData> get userData => _userData;
  void setUserData(Either<Failure, UserData> userData) {
    _userData = userData;
  }

  void registerUser(
      String email, String password, String firstName, String lastName) async {
    _setState(NotifierState.loading);

    await Task(() =>
            registerWithEmailPassword(email, password, firstName, lastName))
        .attempt()
        .map((either) => either.leftMap((obj) => obj as Failure))
        .run()
        .then((userData) => setUserData(userData));

    _setState(NotifierState.loaded);
  }
}
