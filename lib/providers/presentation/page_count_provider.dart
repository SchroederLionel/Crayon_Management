import 'package:flutter/material.dart';

class PageCountProvider extends ChangeNotifier {
  bool showPageCount = false;
  int totalPageCount = 0;
  int currentPageNumber = 0;

  initValue(int totalPageCount, int currentPageNumber) {
    this.totalPageCount = totalPageCount;
    this.currentPageNumber = currentPageNumber;
  }

  increasePageCount() {
    if (currentPageNumber < totalPageCount) {
      currentPageNumber++;
      notifyListeners();
    }
  }

  deacreasePageCount() {
    if (currentPageNumber >= 1) {
      currentPageNumber--;

      notifyListeners();
    }
  }

  changeShowPageCount() {
    showPageCount = !showPageCount;
    notifyListeners();
  }
}
