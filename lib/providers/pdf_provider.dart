import 'dart:typed_data';

import 'package:crayon_management/datamodels/dropped_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PdfProvider extends ChangeNotifier {
  late Uint8List _droppedFile;
  late String _title = '';
  late String _fileName = '';
  late String _fileURL = '';
  Color _currentColor = Colors.blueAccent;

  String get getTitle => _title;
  String get getFileUrl => _fileURL;
  Uint8List get getDroppedFile => _droppedFile;

  Color get currentColor => _currentColor;
  void setDroppedFile(Uint8List file) => _droppedFile = file;

  void updateValues(String mime, String url, String fileName, Uint8List file) {
    String fileType = mime;
    print(mime);
    if (fileType.toUpperCase().contains('PDF')) {
      _fileName = fileName;
      _fileURL = url;
      _currentColor = Colors.greenAccent;
      _droppedFile = file;
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
