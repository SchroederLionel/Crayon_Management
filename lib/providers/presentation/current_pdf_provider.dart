import 'package:flutter/cupertino.dart';
import 'package:pdf_render/pdf_render.dart';

class CurrentPdfProvider {
  PdfDocument? _currentPdfDocument;

  PdfDocument? get currentPdfDocument => _currentPdfDocument;
  setCurrentPdfDocument(PdfDocument? pdfDocument) {
    _currentPdfDocument = pdfDocument;
  }
}
