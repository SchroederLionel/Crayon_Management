import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/datamodels/route_arguments/quiz_launch.dart';
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
import 'package:crayon_management/route/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';

class PresentationOptionsRow extends StatelessWidget {
  final List<Quiz> quizes;
  final Lecture lecture;
  const PresentationOptionsRow(
      {required this.quizes, required this.lecture, Key? key})
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => WidgetsBinding.instance!
                .addPostFrameCallback((_) => showOptionProvider.changeShow()),
            icon: const Icon(Icons.remove_red_eye)),
        IconButton(
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return QrDialog(lectureId: lecture.id);
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
        quizes.isEmpty
            ? const SizedBox()
            : ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(route.quiz,
                      arguments: QuizLaunchArguement(
                          lecture: lecture, quizes: quizes));
                },
                child: Text('Open quiz mode')),
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
