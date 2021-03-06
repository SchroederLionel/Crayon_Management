import 'package:crayon_management/datamodels/confirmation_dialog/confirmation_dialog_data.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/drop_down_type_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:crayon_management/providers/user/user_lectures_provider.dart';
import 'package:crayon_management/screens/dashboard/components/add_modify_lecture_components/add_lecture_dialog.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:provider/provider.dart';

class LectureInfoCard extends StatelessWidget {
  final LectureSnipped lecture;
  const LectureInfoCard({required this.lecture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                lecture.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MultiProvider(
                              providers: [
                                ChangeNotifierProvider<LectureDateProvider>(
                                  create: (_) => LectureDateProvider(),
                                ),
                                ChangeNotifierProvider<DropDownDayProvider>(
                                  create: (context) => DropDownDayProvider(),
                                ),
                                ChangeNotifierProvider<TimePickerProvider>(
                                  create: (context) => TimePickerProvider(),
                                ),
                                ChangeNotifierProvider<DropDownTypeProvider>(
                                  create: (context) => DropDownTypeProvider(),
                                )
                              ],
                              child: AddLectureDialog(
                                lectureSnipped: lecture,
                              ));
                        }).then((updatedLecture) {
                      if (updatedLecture is LectureSnipped) {
                        print(updatedLecture.title);
                        Provider.of<UserLectureProvider>(context, listen: false)
                            .updateLecture(updatedLecture);
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.amberAccent,
                  ))
            ]),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              appTranslation!.translate('dates') ?? 'Dates',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 5),
                itemCount: lecture.lectureDates.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            lecture.lectureDates[index].room,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            lecture.lectureDates[index].day,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Text(
                          lecture.lectureDates[index].startingTime.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          lecture.lectureDates[index].endingTime.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 4.0),
                          width: 50,
                          child: Text(
                            lecture.lectureDates[index].type,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, route.detailedLecture,
                          arguments: lecture);
                    },
                    icon: const Icon(Icons.open_in_browser),
                    label: Text(
                      appTranslation.translate('open') ?? 'Open',
                    )),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ConfirmationDialog(
                                  confirmationDialogData:
                                      ConfirmationDialogData(
                                itemTitle: lecture.title,
                              ))).then((value) {
                        if (value == true) {
                          try {
                            Provider.of<UserLectureProvider>(context,
                                    listen: false)
                                .removeLecture(lecture.getLectureSnipped);
                          } catch (e) {
                            print(e);
                          }
                        }
                      });
                    },
                    icon: const Icon(Icons.delete),
                    label: Text(appTranslation.translate('delete') ?? 'Delete'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
