import 'package:flutter/material.dart';

class PageCountProvider extends ChangeNotifier {
  bool showPageCount = false;
  int totalPageCount = 0;
  int currentPageNumber = 0;

  initValue(int totalPageCount, int currentPageNumber) {
    this.totalPageCount = totalPageCount;
    this.currentPageNumber = currentPageNumber;
  }

  int increasePageCount() {
    if (currentPageNumber < totalPageCount) {
      currentPageNumber++;
      notifyListeners();
    }
    return currentPageNumber;
  }

  int deacreasePageCount() {
    if (currentPageNumber > 0) {
      currentPageNumber--;
      notifyListeners();
    }
    return currentPageNumber;
  }

  changeShowPageCount() {
    showPageCount = !showPageCount;
    notifyListeners();
  }
}
