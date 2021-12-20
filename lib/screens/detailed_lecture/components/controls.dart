import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controls extends StatefulWidget {
  final List<Slide> slides;
  final Lecture lecture;
  const Controls({required this.lecture, required this.slides, Key? key})
      : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  Slide? currentSlide;

  @override
  initState() {
    super.initState();
    currentSlide = widget.slides.first;
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    bool isScreenWide = MediaQuery.of(context).size.width >= 650;

    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: [
        Row(
          children: [
            DropdownButton<Slide>(
                value: currentSlide,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 18,
                elevation: 16,
                style: Theme.of(context).textTheme.bodyText1,
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (Slide? slide) {
                  setState(() {
                    currentSlide = slide!;
                  });
                },
                items:
                    widget.slides.map<DropdownMenuItem<Slide>>((Slide slide) {
                  return DropdownMenuItem<Slide>(
                    value: slide,
                    child: Text(slide.title),
                  );
                }).toList()),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(
                    context, route.presentation,
                    arguments: PresentationScreenArgument(
                        quizes:
                            Provider.of<QuizProvider>(context, listen: false)
                                .quizes
                                .fold((l) => [], (quizes) => quizes),
                        lecture: widget.lecture,
                        fileId: currentSlide!.fileId)),
                icon: const Icon(Icons.open_in_browser),
                label: Text(
                    appTranslation!.translate('openSlide') ?? 'Open Slide')),
          ],
        )
      ],
    );
  }
}
