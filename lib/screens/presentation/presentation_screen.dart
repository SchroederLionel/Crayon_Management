import 'dart:typed_data';
import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/providers/presentation/current_pdf_provider.dart';
import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/presentation/show_options_provider.dart';
import 'package:crayon_management/screens/presentation/components/page_count.dart';
import 'package:crayon_management/screens/presentation/components/presentation_controls.dart';
import 'package:crayon_management/screens/presentation/components/presentation_options_row.dart';
import 'package:crayon_management/screens/presentation/components/question.dart';
import 'package:crayon_management/services/question_service.dart';
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
  Size? size;
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<PresentationProvider>(context, listen: false)
          .getSlide(widget.arg.fileId);
      Provider.of<QuizSelectorProvider>(context, listen: false).quizes =
          widget.arg.quizes;
    });
  }

  @override
  void dispose() {
    _jumpToPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size ??= MediaQuery.of(context).size;

    final currentPdfProvider =
        Provider.of<CurrentPdfProvider>(context, listen: false);
    final pageCountProvider =
        Provider.of<PageCountProvider>(context, listen: false);

    return SafeArea(
      child: Consumer<PresentationProvider>(
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
                                  minCacheExtent: 4,
                                  initialScrollIndex: 0,
                                  itemCount: pageCount,
                                  itemScrollController: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => SizedBox(
                                        height: size!.height - 80,
                                        width: size!.width - 100,
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
                        Consumer<ShowOptionProvider>(
                            builder: (_, showOptionProvider, __) {
                          return showOptionProvider.show
                              ? PresentationOptionsRow(
                                  lecture: arguement.lecture,
                                  quizes: arguement.quizes)
                              : IconButton(
                                  onPressed: () => WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        showOptionProvider.changeShow();
                                      }),
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white24,
                                  ));
                        }),
                        PresentationControls(
                            scrollController: _scrollController),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: StreamProvider<List<String>>(
                            create: (context) =>
                                QuestionService.getQuestionSnapshots(
                                    arguement.lecture.id),
                            initialData: const [],
                            child: Question(
                              lectureId: arguement.lecture.id,
                            ),
                          ),
                        ),
                        const PageCount()
                      ],
                    ));
        } else {
          return Container();
        }
      }),
    );
  }
}
