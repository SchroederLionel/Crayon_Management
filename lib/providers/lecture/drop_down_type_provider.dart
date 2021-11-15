import 'package:flutter/cupertino.dart';

class DropDownTypeProvider extends ChangeNotifier {
  String _currentType = 'lecture';
  String get currentType => _currentType;

  void setCurrentType(String type) {
    _currentType = type;
    notifyListeners();
  }
}
