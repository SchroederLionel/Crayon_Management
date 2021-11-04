import 'package:flutter/material.dart';

class ColorPickerProvider extends ChangeNotifier {
  Color selectedColor = Colors.white;
  List<Color> availableColors = [
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.yellow,
    Colors.blueAccent,
    Colors.purple,
    Colors.green
  ];
  setColorSelected(int index) {
    selectedColor = availableColors[index];
    notifyListeners();
  }
}
