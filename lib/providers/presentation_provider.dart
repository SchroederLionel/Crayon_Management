import 'package:flutter/material.dart';

class PresentationProvider extends ChangeNotifier {
  final int startingPage = 1;

  int currentPage = 1;
  late int totalNumberOfPages;

  int get getcurrentpage => currentPage;

  set totalNumber(int totalNumberOfPages) =>
      this.totalNumberOfPages = totalNumberOfPages;

  void changePageNumer(int pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }

  void goToNextPage() {
    currentPage++;
    notifyListeners();
  }

  void goToPreviousPage() {
    currentPage--;
    notifyListeners();
  }
}
