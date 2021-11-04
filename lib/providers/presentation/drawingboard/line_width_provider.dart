import 'package:flutter/cupertino.dart';

class LineWidthProvider extends ChangeNotifier {
  double strokeWidth = 5;
  setBoardWidth(double newStrokeWidth) {
    strokeWidth = newStrokeWidth;
    notifyListeners();
  }
}
