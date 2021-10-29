import 'dart:typed_data';
import 'dart:html';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';

import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:provider/provider.dart';

class DialogPresentation extends StatefulWidget {
  final String fileName;
  const DialogPresentation({required this.fileName, Key? key})
      : super(key: key);

  @override
  State<DialogPresentation> createState() => _DialogPresentationState();
}

class _DialogPresentationState extends State<DialogPresentation> {
  Uint8List? pdf;
  late PdfController pdfController;

  @override
  void initState() {
    super.initState();
    final presentationProvider =
        Provider.of<PresentationProvider>(context, listen: false);
    presentationProvider.changeIsLoading(widget.fileName);
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final presentationProvider =
        Provider.of<PresentationProvider>(context, listen: true);

    if (presentationProvider.isLoading == true) {
      return const Center(
          child: SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator()));
    } else {
      PdfController pdfController = PdfController(
        document: PdfDocument.openData(presentationProvider.getPdf),
      );
      return Stack(
        children: [
          Consumer<PresentationProvider>(
            builder: (context, pdfProvider, child) {
              return PdfView(
                controller: pdfController,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    document.documentElement!.requestFullscreen();
                  },
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ))
            ],
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      pdfController.previousPage(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeIn);
                    },
                    icon: const Icon(
                      Icons.arrow_left,
                      color: Colors.black,
                      size: 24,
                    )),
                IconButton(
                    onPressed: () {
                      pdfController.nextPage(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeOut);
                    },
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                      size: 24,
                    )),
              ],
            ),
          )
        ],
      );
    }
  }
}
