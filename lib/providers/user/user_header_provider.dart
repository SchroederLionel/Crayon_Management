import 'package:crayon_management/datamodels/enum.dart';
import 'package:flutter/cupertino.dart';

class UserHeaderProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  String firstNameAndLastName = '';

  void setFirstName(String newName) {
    firstNameAndLastName = newName;
    setState(NotifierState.loaded);
  }
}
