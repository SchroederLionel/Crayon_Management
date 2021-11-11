import 'dart:html';

import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/slide_data_provider.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';

class DropZone extends StatefulWidget {
  final String lectureId;
  const DropZone({required this.lectureId, Key? key}) : super(key: key);

  @override
  _DropZoneState createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  late TextEditingController _titleController;
  late SlideDataProvider slideProvider;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    slideProvider = Provider.of<SlideDataProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  late DropzoneViewController controller;
  File? file;
  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);

    return AlertDialog(
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black26)),
            onPressed: () => Navigator.pop(context),
            child: Text(appTranslation!.translate('cancel') ?? 'Cancel')),
        ElevatedButton(
            onPressed: () async {
              if (slideProvider.getTitle.length >= 2 &&
                  slideProvider.getDroppedFile != null) {
                slideProvider.addSlide(widget.lectureId).then((value) => value
                        .fold((failure) => Navigator.pop(context, failure.code),
                            (slide) {
                      Navigator.pop(context, slide);
                    }));
              }
            },
            child: Text(appTranslation.translate('upload') ?? 'Upload'))
      ],
      content: Builder(
        builder: (context) {
          return Container(
              height: 650,
              width: 500,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    appTranslation.translate('addSlide') ?? 'Add slide',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  CustomTextFormField(
                      validator: (text) =>
                          ValidatorService.isStringLengthAbove2(
                              text, appTranslation),
                      onChanged: (String text) => slideProvider.setTitle(text),
                      controller: _titleController,
                      icon: Icons.book_rounded,
                      labelText:
                          appTranslation.translate('pdfTitle') ?? 'PdfTitle',
                      isPassword: false),
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
                                    appTranslation.translate('chooseFile') ??
                                        'Choose file',
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
                                  appTranslation.translate('dropFileHere') ??
                                      'Drop file here',
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
    file = event as File;
    final mime = await controller.getFileMIME(event);
    slideProvider.updateValues(_titleController.text, event, mime);
  }
}
