import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/current_pdf_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/canvas_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/color_picker_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/line_width_provider.dart';
import 'package:crayon_management/providers/presentation/drawingboard/pdf_provider.dart';
import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/presentation/show_options_provider.dart';
import 'package:crayon_management/screens/presentation/components/drawboard.dart';
import 'package:crayon_management/screens/presentation/components/qr_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';

class PresentationOptionsRow extends StatelessWidget {
  final String lectureId;
  const PresentationOptionsRow({required this.lectureId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPdfProvider =
        Provider.of<CurrentPdfProvider>(context, listen: false);
    final pageCountProvider =
        Provider.of<PageCountProvider>(context, listen: false);

    final showOptionProvider =
        Provider.of<ShowOptionProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => showOptionProvider.changeShow(),
            icon: const Icon(Icons.remove_red_eye)),
        IconButton(
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return QrDialog(lectureId: lectureId);
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
              Icons.bookmark_add_outlined,
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
                          pdfDocument: currentPdfProvider.currentPdfDocument,
                          currentPage: pageCountProvider.currentPageNumber + 1,
                        ),
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.app_registration,
              color: Colors.white24,
            )),
        const SizedBox(
          width: 14,
        ),
        Consumer<QuizSelectorProvider>(
          builder: (_, quizSelector, __) {
            return DropdownButton<Quiz>(
                value: quizSelector.currentQuiz,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 14,
                style: const TextStyle(fontSize: 14, color: Colors.white24),
                underline: Container(
                  height: 0,
                ),
                onChanged: (Quiz? quiz) {
                  if (quiz != null) {
                    quizSelector.changeQuiz(quiz);
                  }
                },
                items: quizSelector.quizes
                    .map<DropdownMenuItem<Quiz>>((Quiz quiz) {
                  return DropdownMenuItem<Quiz>(
                    value: quiz,
                    child: Text(quiz.title),
                  );
                }).toList());
          },
        ),
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
    );
  }
}
