import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:flutter/material.dart';

enum NotifierState { initial, loading, loaded }

class FailureProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late UserData _userData;
  UserData get userData => _userData;
  void _setUserData(UserData user) {
    _userData = user;
  }

  late Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
  }

  void getUser(String email, String password) async {
    _setState(NotifierState.loading);
    try {
      final userData = await signInWithEmailPassword(email, password);
      if (userData is UserData) {
        _setUserData(userData);
      }
    } on Failure catch (f) {
      _setFailure(f);
    }
    _setState(NotifierState.loaded);
  }
}
