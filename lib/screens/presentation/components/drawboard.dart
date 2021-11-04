import 'dart:ui';

import 'package:crayon_management/datamodels/drawboard/drawing_point.dart';
import 'package:crayon_management/providers/presentation/drawingboard/canvas_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/color_picker_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/line_width_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/pdf_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';

class DrawBoard extends StatefulWidget {
  final PdfDocument? pdfDocument;
  final int currentPage;
  const DrawBoard(
      {required this.pdfDocument, required this.currentPage, Key? key})
      : super(key: key);

  @override
  State<DrawBoard> createState() => _DrawBoardState();
}

class _DrawBoardState extends State<DrawBoard> {
  double strokeWidth = 5;
  bool showCurrentPDF = false;
  List<DrawingPoint?> drawingPoints = [];
  late final int currentPageNumber;
  late final PdfDocument? pdfDocument;
  late final CanvasProvider canvasProvider;
  late final LineWidthProvider lineWidthProvider;
  late final ColorPickerProvider colorPickerProvider;
  late final PdfProvider pdfProvider;

  @override
  void initState() {
    super.initState();
    currentPageNumber = widget.currentPage;
    pdfDocument = widget.pdfDocument;
    canvasProvider = Provider.of<CanvasProvider>(context, listen: false);
    lineWidthProvider = Provider.of<LineWidthProvider>(context, listen: false);
    colorPickerProvider =
        Provider.of<ColorPickerProvider>(context, listen: false);
    pdfProvider = Provider.of<PdfProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<PdfProvider>(
              builder: (context, pdfProvider, child) => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: pdfProvider.showCurrentPdfPage
                      ? PdfPageView(
                          pageNumber: currentPageNumber,
                          pdfDocument: pdfDocument,
                          pageBuilder: (context, textureBuilder, pageSize) {
                            return Center(
                              child: textureBuilder(),
                            );
                          },
                        )
                      : null)),
          Consumer<CanvasProvider>(
              builder: (context, canvasProvider, child) => GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) => canvasProvider
                        .onPanUpdate(details, lineWidthProvider.strokeWidth),
                    onPanStart: (details) => canvasProvider.onPanStart(
                        details, lineWidthProvider.strokeWidth),
                    onPanEnd: (details) =>
                        canvasProvider.onPanEndPoint(details),
                    child: CustomPaint(
                      painter: _DrawingPainter(canvasProvider.drawingPoints),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  )),
          Positioned(
            top: 40,
            left: 20,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => canvasProvider.reserBoard(),
                      icon: const Icon(Icons.delete, color: Colors.blueAccent)),
                  IconButton(
                      onPressed: () => pdfProvider.changeShow(),
                      icon: const Icon(Icons.remove_red_eye,
                          color: Colors.blueAccent)),
                  Consumer<LineWidthProvider>(
                    builder: (context, lineWidthProvider, child) => Slider(
                      min: 0,
                      max: 40,
                      value: lineWidthProvider.strokeWidth,
                      onChanged: (val) => lineWidthProvider.setBoardWidth(val),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.blueAccent))
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: const Color(0xFF2A2D3E),
          padding: const EdgeInsets.all(10),
          child: Consumer<ColorPickerProvider>(
            builder: (context, colorPickerProvider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  colorPickerProvider.availableColors.length,
                  (index) => _buildColorPicker(index)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker(int index) {
    bool isSelected = colorPickerProvider.selectedColor ==
        colorPickerProvider.availableColors[index];
    return GestureDetector(
      onTap: () {
        colorPickerProvider.setColorSelected(index);
        canvasProvider.selectedColor = colorPickerProvider.selectedColor;
      },
      child: Container(
        height: isSelected ? 50 : 40,
        width: isSelected ? 50 : 40,
        decoration: BoxDecoration(
            color: colorPickerProvider.availableColors[index],
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
                    color: colorPickerProvider.availableColors[index], width: 4)
                : null),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  List<Offset> offsetsList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length; i++) {
      var counter = i + 1;

      /// checks if next drawing is possible
      if (drawingPoints.length > counter) {
        if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
          canvas.drawLine(drawingPoints[i]!.offset,
              drawingPoints[i + 1]!.offset, drawingPoints[i]!.paint);
        } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
          offsetsList.clear();
          offsetsList.add(drawingPoints[i]!.offset);

          canvas.drawPoints(
              PointMode.points, offsetsList, drawingPoints[i]!.paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
