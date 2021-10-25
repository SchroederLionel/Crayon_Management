import 'package:crayon_management/datamodels/confirmation_dialog/confirmation_dialog_data.dart';

import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';

import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';

import 'package:crayon_management/services/lecture_service.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LectureInfoCard extends StatelessWidget {
  final LectureSnipped lecture;
  const LectureInfoCard({required this.lecture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              lecture.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 14.0,
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              translation!.dates,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 15),
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
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            lecture.lectureDates[index].room,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            lecture.lectureDates[index].day,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            lecture.lectureDates[index].startingTime,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            lecture.lectureDates[index].endingTime,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Container(
                            width: 100,
                            child: Text(
                              lecture.lectureDates[index].type,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, route.presentation,
                          arguments: lecture);
                    },
                    icon: const Icon(Icons.open_in_browser),
                    label: Text(translation.open)),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ConfirmationDialog(
                              confirmationDialogData: ConfirmationDialogData(
                                  title: translation.delete,
                                  cancelTitle: translation.cancel,
                                  itemTitle: lecture.title,
                                  description: translation.confirmationDeletion,
                                  acceptTitle: translation.yes))).then((value) {
                        if (value == true) {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          LectureService.deleteLecture(
                              lecture, userProvider.getUserId);
                          userProvider.removeLecture(lecture);
                        }
                      });
                    },
                    icon: const Icon(Icons.delete),
                    label: Text(translation.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}

/**
 * 
 * 
 * 
 * const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, route.presentation,
                          arguments: lecture);
                    },
                    icon: Icon(Icons.open_in_browser),
                    label: Text(translation.open)),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ConfirmationDialog(
                              confirmationDialogData: ConfirmationDialogData(
                                  title: translation.delete,
                                  cancelTitle: translation.cancel,
                                  itemTitle: lecture.title,
                                  description: translation.confirmationDeletion,
                                  acceptTitle: translation.yes)));
                    },
                    icon: Icon(Icons.delete),
                    label: Text(translation.delete))
              ],
            )
 */
