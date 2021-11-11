import 'package:flutter/cupertino.dart';

class ShowOptionProvider extends ChangeNotifier {
  bool _show = false;

  bool get show => _show;

  changeShow() {
    _show = !_show;
    notifyListeners();
  }
}
