import 'dart:html';

import 'package:crayon_management/datamodels/dropped_file.dart';
import 'package:crayon_management/providers/slide_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DropZone extends StatefulWidget {
  const DropZone({Key? key}) : super(key: key);

  @override
  _DropZoneState createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  late DropzoneViewController controller;
  DroppedFile? file;
  @override
  Widget build(BuildContext context) {
    final pdfProvider = Provider.of<SlideDataProvider>(context, listen: false);
    var translation = AppLocalizations.of(context);
    return AlertDialog(
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black26)),
            onPressed: () => Navigator.pop(context),
            child: Text(translation!.cancel)),
        ElevatedButton(
            onPressed: () {
              if (pdfProvider.getTitle.length >= 4 &&
                  pdfProvider.getDroppedFile != null) {
                Navigator.pop(context, pdfProvider);
              }
            },
            child: Text(translation.upload))
      ],
      content: Builder(
        builder: (context) {
          return Container(
              height: 630,
              width: 500,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    translation.addSlide,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (val) => !isByteLength(val!, 4)
                            ? translation.titleHasToHaveAtLeast4Chars
                            : null,
                        onChanged: (String text) => pdfProvider.title(text),
                        controller: _titleController,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.book_rounded,
                              size: 18,
                            ),
                            border: const UnderlineInputBorder(),
                            labelText: translation.pdfTitle),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Consumer<SlideDataProvider>(
                    builder: (context, pdf, child) {
                      return Container(
                        height: 500,
                        width: 460,
                        decoration: BoxDecoration(
                            border: Border.all(color: pdf.currentColor)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropzoneView(
                                onCreated: (controller) =>
                                    this.controller = controller,
                                onDrop: acceptFile),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  size: 80,
                                  color: pdf.currentColor,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.search,
                                  ),
                                  label: Text(
                                    translation.chooseFile,
                                  ),
                                  onPressed: () async {
                                    final events = await controller.pickFiles();
                                    if (events.isEmpty) return;
                                    acceptFile(events.first);
                                  },
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  translation.dropFileHere,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(pdf.getTitle,
                                    style:
                                        Theme.of(context).textTheme.bodyText1)
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ));
        },
      ),
    );
  }

  Future acceptFile(event) async {
    final pdfProvider = Provider.of<SlideDataProvider>(context, listen: false);
    final mime = await controller.getFileMIME(event);
    final String fileName = await controller.getFilename(event);
    final url = await controller.createFileUrl(event);

    pdfProvider.updateValues(_titleController.text, event, mime, fileName);
  }
}
