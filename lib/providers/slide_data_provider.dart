import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideDataProvider extends ChangeNotifier {
  late String _title = '';

  late File? _file;

  Color _currentColor = Colors.blueAccent;

  String get getTitle => _title;

  File? get getDroppedFile => _file;
  Color get currentColor => _currentColor;

  void updateValues(String title, File file, String fileType) {
    if (fileType.toUpperCase().contains('PDF')) {
      _currentColor = Colors.greenAccent;
      _file = file;
    } else {
      _title = 'Only PDF file type is accepted';
      _currentColor = Colors.redAccent;
    }
    notifyListeners();
  }

  void setTitle(String title) => _title = title;
  void setFile(File file) => _file = file;
}
