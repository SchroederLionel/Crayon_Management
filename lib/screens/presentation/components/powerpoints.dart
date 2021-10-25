import 'package:crayon_management/datamodels/confirmation_dialog/confirmation_dialog_data.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';

import 'package:crayon_management/providers/detailed_lecture_provider.dart';

import 'package:crayon_management/providers/slide_data_provider.dart';

import 'package:crayon_management/screens/presentation/components/add_slide/drop_zone.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Powerpoints extends StatefulWidget {
  final Lecture lecture;
  const Powerpoints({required this.lecture, Key? key}) : super(key: key);

  @override
  State<Powerpoints> createState() => _PowerpointsState();
}

class _PowerpointsState extends State<Powerpoints> {
  late Lecture lecture;

  @override
  void initState() {
    super.initState();
    lecture = widget.lecture;
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final detailLectureProvider =
        Provider.of<DetailedLectureProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translation!.slides,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ListenableProvider<SlideDataProvider>(
                          create: (context) => SlideDataProvider(),
                          child: const DropZone(),
                        );
                      }).then((value) {
                    if (value != null) {
                      detailLectureProvider.addSlide(
                          lecture.id, value.getTitle, value.getDroppedFile);
                    }
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.addSlide))
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: lecture.slides.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lecture.slides[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ConfirmationDialog(
                                        confirmationDialogData:
                                            ConfirmationDialogData(
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .delete,
                                                itemTitle: detailLectureProvider
                                                    .lecture!
                                                    .slides[index]
                                                    .title,
                                                cancelTitle: AppLocalizations
                                                        .of(context)!
                                                    .cancel,
                                                description: translation
                                                    .confirmationDeletion,
                                                acceptTitle:
                                                    AppLocalizations.of(
                                                            context)!
                                                        .yes))).then((value) {
                              if (value == true) {
                                detailLectureProvider.removeSlide(
                                    lecture.id,
                                    detailLectureProvider
                                        .lecture!.slides[index]);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ))
                    ],
                  ),
                );
              },
            )),
      ],
    );
  }
}
