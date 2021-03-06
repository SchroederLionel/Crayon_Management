import 'package:crayon_management/datamodels/confirmation_dialog/confirmation_dialog_data.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/slide_data_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/add_slide/drop_zone.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:crayon_management/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidesComponent extends StatefulWidget {
  final Lecture lecture;
  const SlidesComponent({required this.lecture, Key? key}) : super(key: key);

  @override
  State<SlidesComponent> createState() => _SlidesComponentState();
}

class _SlidesComponentState extends State<SlidesComponent> {
  late Lecture lecture;

  @override
  void initState() {
    super.initState();
    lecture = widget.lecture;
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
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
              appTranslation!.translate('slides') ?? 'Slides',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ListenableProvider<SlideDataProvider>(
                          create: (context) => SlideDataProvider(),
                          child: DropZone(lectureId: lecture.id),
                        );
                      }).then((value) {
                    if (value is Slide) {
                      detailLectureProvider.addSlide(value);
                    } else if (value is String) {
                      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                          text: appTranslation.translate(value) ??
                              'Something went wrong',
                          color: Colors.red));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                          text: 'Something went wrong', color: Colors.red));
                    }
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(
                  appTranslation.translate('addSlide') ?? 'Add slide',
                ))
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
          height: 70,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: lecture.slides.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                      itemTitle: lecture.slides[index].title,
                                    ))).then((value) {
                              if (value == true) {
                                detailLectureProvider.removeSlide(
                                    widget.lecture.id, lecture.slides[index]);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
