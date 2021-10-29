import 'dart:html';
import 'dart:typed_data';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/providers/presentation/presentation_provider.dart';
import 'package:crayon_management/screens/presentation/components/dialog_presentation/dialog_presentation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Controls extends StatelessWidget {
  final List<Slide> slides;
  Controls({required this.slides, Key? key}) : super(key: key);

  _launchURL(BuildContext context, String fileName) {
    ItemScrollController _scrollController = ItemScrollController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showGeneralDialog(
        barrierColor: Colors.black,
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            child: ListenableProvider<PresentationProvider>(
              create: (context) => PresentationProvider(),
              child: DialogPresentation(
                fileName: fileName,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    bool isScreenWide = MediaQuery.of(context).size.width >= 650;
    String currentfileName = slides.first.fileId;
    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: [
        slides.isEmpty
            ? Container()
            : Row(
                children: [
                  DropdownButton<Slide>(
                      value: slides.first,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 18,
                      elevation: 16,
                      style: Theme.of(context).textTheme.bodyText1,
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (Slide? file) {
                        currentfileName = file!.fileId;
                      },
                      items: slides.map<DropdownMenuItem<Slide>>((Slide slide) {
                        return DropdownMenuItem<Slide>(
                          value: slide,
                          child: Text(slide.title),
                        );
                      }).toList()),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () => _launchURL(context, currentfileName),
                      icon: const Icon(Icons.open_in_browser),
                      label: Text(translation!.openSlide)),
                ],
              )
      ],
    );
  }
}
