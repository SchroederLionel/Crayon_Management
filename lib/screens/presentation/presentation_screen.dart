import 'dart:typed_data';
import 'dart:html';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/providers/presentation/drawingboard/canvas_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/color_picker_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/line_width_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/pdf_provider.dart';
import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';
import 'package:crayon_management/screens/presentation/components/drawboard.dart';
import 'package:crayon_management/screens/presentation/components/qr_dialog.dart';
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
  late PdfPage currentPdfPage;
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
    final presentationProvider =
        Provider.of<PresentationProvider>(context, listen: false);
    presentationProvider.changeIsLoading(widget.arg.fileId);
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
    final presentationProvider =
        Provider.of<PresentationProvider>(context, listen: true);
    final pageCountProvider =
        Provider.of<PageCountProvider>(context, listen: false);

    if (presentationProvider.isLoading == true) {
      return const Center(
          child: SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator()));
    } else {
      return Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: PdfDocumentLoader.openData(presentationProvider.getPdf,
                  documentBuilder: (context, pdfDocument, pageCount) {
                return LayoutBuilder(builder: (context, constraints) {
                  pageCountProvider.initValue(pageCount, 1);
                  currentPdfDocument = pdfDocument;
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
                              pageBuilder: (context, textureBuilder, pageSize) {
                                return Center(
                                  child: textureBuilder(),
                                );
                              },
                            ),
                          ));
                });
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return QrDialog(lectureId: arguement.lecture.id);
                        });
                  },
                  icon: const Icon(
                    Icons.qr_code,
                    color: Colors.white24,
                  )),
              IconButton(
                  onPressed: () {
                    pageCountProvider.changeShowPageCount();
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.white24,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: MultiProvider(
                              providers: [
                                ChangeNotifierProvider<CanvasProvider>(
                                    create: (context) => CanvasProvider()),
                                ChangeNotifierProvider<LineWidthProvider>(
                                    create: (context) => LineWidthProvider()),
                                ChangeNotifierProvider<ColorPickerProvider>(
                                  create: (context) => ColorPickerProvider(),
                                ),
                                ChangeNotifierProvider<PdfProvider>(
                                  create: (context) => PdfProvider(),
                                )
                              ],
                              child: DrawBoard(
                                pdfDocument: currentPdfDocument,
                                currentPage:
                                    pageCountProvider.currentPageNumber,
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.app_registration,
                    color: Colors.white24,
                  )),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (document.documentElement != null) {
                      document.documentElement!.requestFullscreen();
                    }
                  },
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white24,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white24,
                  ))
            ],
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {
                      _scrollController.scrollTo(
                          index: pageCountProvider.deacreasePageCount(),
                          duration: const Duration(milliseconds: 200));
                      currentPdfPage = await currentPdfDocument!
                          .getPage(pageCountProvider.currentPageNumber);
                    },
                    icon: const Icon(
                      Icons.arrow_left,
                      color: Colors.white24,
                      size: 24,
                    )),
                IconButton(
                    onPressed: () async {
                      _scrollController.scrollTo(
                          index: pageCountProvider.increasePageCount(),
                          duration: const Duration(milliseconds: 200));
                      currentPdfPage = await currentPdfDocument!
                          .getPage(pageCountProvider.currentPageNumber);
                    },
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Colors.white24,
                      size: 24,
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            alignment: Alignment.bottomRight,
            child: Consumer<PageCountProvider>(
              builder: (context, pageCountProvider, child) {
                if (pageCountProvider.showPageCount) {
                  return Text(
                    '${pageCountProvider.currentPageNumber}/${pageCountProvider.totalPageCount}',
                    style: const TextStyle(color: Colors.white24),
                  );
                }
                return Container();
              },
            ),
          )
        ],
      );
    }
  }
}
