import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideDataProvider extends ChangeNotifier {
  late String _title = '';
  late String _fileName = '';
  late String _fileURL = '';
  late File _file;

  Color _currentColor = Colors.blueAccent;

  String get getTitle => _title;
  String get getFileUrl => _fileURL;
  File get getDroppedFile => _file;
  Color get currentColor => _currentColor;

  void updateValues(String title, File file, String fileType, String fileName) {
    if (fileType.toUpperCase().contains('PDF')) {
      _fileName = fileName;
      _currentColor = Colors.greenAccent;
      _file = file;
    } else {
      _title = 'Only PDF file type is accepted';
      _currentColor = Colors.redAccent;
    }
    notifyListeners();
  }

  void title(String title) => _title = title;

  void fileURL(String url) {
    _fileURL = url;
    notifyListeners();
  }
}
