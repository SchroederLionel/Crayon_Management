import 'package:crayon_management/datamodels/drawboard/drawing_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CanvasProvider extends ChangeNotifier {
  Color selectedColor = Colors.white;
  bool showCurrentPDF = false;
  List<DrawingPoint?> drawingPoints = [];

  reserBoard() {
    drawingPoints = [];
    notifyListeners();
  }

  onPanUpdate(DragUpdateDetails details, double strokeWidth) {
    drawingPoints.add(DrawingPoint(
        details.localPosition,
        Paint()
          ..color = selectedColor
          ..isAntiAlias = true
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round));
    notifyListeners();
  }

  onPanStart(DragStartDetails details, double strokeWidth) {
    drawingPoints.add(DrawingPoint(
        details.localPosition,
        Paint()
          ..color = selectedColor
          ..isAntiAlias = true
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round));
    notifyListeners();
  }

  onPanEndPoint(DragEndDetails details) {
    drawingPoints.add(null);
    notifyListeners();
  }
}
