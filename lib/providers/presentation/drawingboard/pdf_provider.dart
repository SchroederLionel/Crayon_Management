import 'package:flutter/cupertino.dart';

class PdfProvider extends ChangeNotifier {
  bool showCurrentPdfPage = false;

  changeShow() {
    showCurrentPdfPage = !showCurrentPdfPage;
    notifyListeners();
  }
}
