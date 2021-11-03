import 'dart:html';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/datamodels/route_arguments/presentation_screen_argument.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Controls extends StatefulWidget {
  final Lecture lecture;
  const Controls({required this.lecture, Key? key}) : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  late Slide currentSlide;

  initState() {
    currentSlide = widget.lecture.slides.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    bool isScreenWide = MediaQuery.of(context).size.width >= 650;

    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: [
        widget.lecture.slides.isEmpty
            ? Container()
            : Row(
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
                      onChanged: (Slide? file) {
                        setState(() {
                          currentSlide = file!;
                        });
                      },
                      items: widget.lecture.slides
                          .map<DropdownMenuItem<Slide>>((Slide slide) {
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
                              lecture: widget.lecture,
                              fileId: currentSlide.fileId)),
                      icon: const Icon(Icons.open_in_browser),
                      label: Text(translation!.openSlide)),
                ],
              )
      ],
    );
  }
}
