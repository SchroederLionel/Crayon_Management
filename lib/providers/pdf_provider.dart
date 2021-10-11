import 'package:crayon_management/datamodels/dropped_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PdfProvider extends ChangeNotifier {
  late DroppedFile _droppedFile;
  late String _title = '';
  late String _fileURL = '';
  Color _currentColor = Colors.blueAccent;

  String get getTitle => _title;
  String get getFileUrl => _fileURL;
  DroppedFile get getDroppedFile => _droppedFile;

  Color get currentColor => _currentColor;
  void droppedFile(DroppedFile file) => _droppedFile = file;

  void updateValues(String mime, String url, String title) {
    String fileType = mime;
    print(mime);
    if (fileType.toUpperCase().contains('PDF')) {
      _title = title;
      _fileURL = url;
      _currentColor = Colors.greenAccent;
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
