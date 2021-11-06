import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<Failure, UserData> _user;

  Either<Failure, UserData> get userData => _user;
  void _setUserData(Either<Failure, UserData> user) {
    _user = user;
  }

  Future<Either<Failure, UserData>> signUserIn(
      String email, String password, BuildContext context) async {
    _setState(NotifierState.loading);

    Either<Failure, UserData> userData =
        await Task(() => signInWithEmailPassword(email, password))
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
    _setUserData(userData);
    _setState(NotifierState.loaded);

    return userData;
  }
}
