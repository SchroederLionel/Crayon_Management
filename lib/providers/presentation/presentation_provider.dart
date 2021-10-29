import 'dart:typed_data';

import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter/cupertino.dart';

class PresentationProvider extends ChangeNotifier {
  bool isLoading = false;

  late int _totalPageNumbers;
  late int _startingPage;
  late int _endingPage;
  late Uint8List _pdf;

  changeIsLoading(String fileName) async {
    print('Loading file');
    isLoading = true;
    var data = await LectureService.getSilde(fileName);

    if (data != null) {
      _pdf = data;
    }
    isLoading = false;
    print('notify Listener');
    notifyListeners();
  }

  goToNextPage() {}

  goToPreviousPage() {}

  Uint8List get getPdf => _pdf;

  setPdf(Uint8List pdf) => _pdf = pdf;
  setStartingPage(int startingPage) => _startingPage = startingPage;
  setEndingPage(int endingPage) => _endingPage = endingPage;
  setTotalPageNumber(int totalPageNumbers) =>
      _totalPageNumbers = totalPageNumbers;
}
