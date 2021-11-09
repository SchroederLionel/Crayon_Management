import 'dart:typed_data';

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/providers/presentation/current_pdf_provider.dart';

import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';

import 'package:crayon_management/screens/presentation/components/page_count.dart';
import 'package:crayon_management/screens/presentation/components/presentation_controls.dart';
import 'package:crayon_management/screens/presentation/components/presentation_options_row.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PresentationScreen extends StatefulWidget {
  final PresentationScreenArgument arg;

  const PresentationScreen({required this.arg, Key? key}) : super(key: key);

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  Uint8List? pdf;
  late Size size;
  late PdfDocument? currentPdfDocument;
  late ItemScrollController _scrollController;
  late TextEditingController _jumpToPageController;
  late PresentationScreenArgument arguement;
  int currentPage = 0;
  int totalPageNumber = 0;
  @override
  void initState() {
    super.initState();
    arguement = widget.arg;
    _jumpToPageController = TextEditingController(text: '');
    _scrollController = ItemScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        Provider.of<PresentationProvider>(context, listen: false)
            .getSlide(widget.arg.fileId));
  }

  @override
  void dispose() {
    _jumpToPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    final currentPdfProvider =
        Provider.of<CurrentPdfProvider>(context, listen: false);
    final pageCountProvider =
        Provider.of<PageCountProvider>(context, listen: false);

    return Consumer<PresentationProvider>(
        builder: (_, presentationNotifier, __) {
      if (presentationNotifier.state == NotifierState.initial) {
        return Container();
      } else if (presentationNotifier.state == NotifierState.loading) {
        return const Center(
            child: SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator()));
      } else if (presentationNotifier.state == NotifierState.loaded) {
        return presentationNotifier.slide.fold(
            (failure) => Center(child: Text(failure.toString())),
            (uint8list) => uint8list == null
                ? Container()
                : Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 40),
                          child: PdfDocumentLoader.openData(uint8list,
                              documentBuilder:
                                  (context, pdfDocument, pageCount) {
                            pageCountProvider.initValue(pageCount, 0);
                            currentPdfProvider
                                .setCurrentPdfDocument(pdfDocument);

                            return ScrollablePositionedList.builder(
                                itemCount: pageCount,
                                itemScrollController: _scrollController,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => SizedBox(
                                      height: height - 80,
                                      width: width - 100,
                                      child: PdfPageView(
                                        pdfDocument: pdfDocument,
                                        pageNumber: index + 1,
                                        pageBuilder: (context, textureBuilder,
                                            pageSize) {
                                          return Center(
                                            child: textureBuilder(),
                                          );
                                        },
                                      ),
                                    ));
                          }),
                        ),
                      ),
                      PresentationOptionsRow(lectureId: arguement.lectureId),
                      PresentationControls(scrollController: _scrollController),
                      const PageCount()
                    ],
                  ));
      } else {
        return Container();
      }
    });
  }
}
