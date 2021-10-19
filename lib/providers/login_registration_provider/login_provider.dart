import 'package:crayon_management/datamodels/user_data.dart';

class UserProvider {
  late UserData _user;
  setUserData(UserData userData) => _user = userData;
  String get getEmail => _user.email;
  String get getFirstName => _user.firstName;
  String get getLastName => _user.lastName;
  String get getFirstAndLastName => '${_user.firstName} ${_user.lastName}';
}
