import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class UserHeaderProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  late UserData _user;
  late String firstNameAndLastName;

  UserData get user => _user;

  void setUserData(UserData user) {
    _user = user;
    setFirstNameLastName(user.firstNameAndLastName);
    setState(NotifierState.loaded);
  }

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void updateUserData(UserData userData) async {
    setState(NotifierState.loading);
    await UserService.updateUser(userData);
    setUserData(userData);
    setState(NotifierState.loaded);
  }

  void setFirstNameLastName(String newName) {
    firstNameAndLastName = newName;
  }
}
