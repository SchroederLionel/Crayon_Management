import 'dart:typed_data';

import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter/cupertino.dart';

class PresentationProvider extends ChangeNotifier {
  bool isLoading = false;

  late Uint8List _pdf;

  changeIsLoading(String fileName) async {
    isLoading = true;
    var data = await LectureService.getSilde(fileName);

    if (data != null) {
      _pdf = data;
    }
    isLoading = false;

    notifyListeners();
  }

  goToNextPage() {}

  goToPreviousPage() {}

  Uint8List get getPdf => _pdf;

  setPdf(Uint8List pdf) => _pdf = pdf;
}
