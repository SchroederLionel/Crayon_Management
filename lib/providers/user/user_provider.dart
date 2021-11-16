// ignore_for_file: file_names

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/user_service.dart';
import 'package:dartz/dartz.dart';

class UserProvider {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  setState(NotifierState state) {
    _state = state;
  }

  late Either<Failure, UserData> _user;
  Either<Failure, UserData> get user => _user;
  setUser(Either<Failure, UserData> user) {
    _user = user;
  }

  Future<Either<Failure, UserData>> getUserData() async {
    return await Task(() => UserService.getUserData())
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
        .then((value) {
      setUser(value);
      return value;
    });
  }
}
