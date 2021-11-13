// ignore_for_file: file_names

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/user_service.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<Failure, UserData> _user;
  Either<Failure, UserData> get user => _user;
  setUser(Either<Failure, UserData> user) {
    _user = user;
  }

  void getUserData() async {
    setState(NotifierState.loading);
    await Task(() => UserService.getUserData())
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
        .run()
        .then((value) => setUser(value));
    setState(NotifierState.loaded);
  }

  void removeLecture(LectureSnipped lecture) {
    _user.fold((l) => null, (user) => user.myLectures.remove(lecture));
  }

  void addLecture(LectureSnipped lecture) {
    _user.fold((l) => null, (user) => user.myLectures.add(lecture));
  }

  void updateUserData(UserData newUserData) {
    _user.fold((l) => null, (user) => user = newUserData);
  }
}
