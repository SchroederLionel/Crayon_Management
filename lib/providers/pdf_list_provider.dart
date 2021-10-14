import 'package:crayon_management/providers/pdf_provider.dart';
import 'package:flutter/cupertino.dart';

class PdfListProvider extends ChangeNotifier {
  List<PdfProvider> pdfProviders = [];

  int get getPdfsLength => pdfProviders.length;

  PdfProvider getPdfProvider(int index) => pdfProviders[index];

  List<PdfProvider> get getPdfs => pdfProviders;
  void remove(PdfProvider pdfProvider) {
    pdfProviders.remove(pdfProvider);
    notifyListeners();
  }

  void add(PdfProvider pdfProvider) {
    pdfProviders.add(pdfProvider);
    notifyListeners();
  }
}
