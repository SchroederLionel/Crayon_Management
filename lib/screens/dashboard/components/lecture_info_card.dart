import 'package:crayon_management/datamodels/confirmation_dialog_data.dart';
import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;

class LectureInfoCard extends StatelessWidget {
  final Lecture lecture;
  const LectureInfoCard({required this.lecture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Text(
                lecture.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Row(
              children: [
                Text(
                  'Last Powerpoint:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  lecture.lastPowerPointTitle,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              'Dates:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Table(
              border: TableBorder.all(color: Theme.of(context).primaryColor),
              children:
                  List<TableRow>.generate(lecture.dates.length, (int index) {
                return TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      lecture.dates[index].room,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      lecture.dates[index].starting_time,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      lecture.dates[index].ending_time,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      getlectureType(lecture.dates[index].type),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ]);
              }),
            ),
            const Spacer(),
            Container(
              child: Row(
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
                      label: Text('Open')),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => ConfirmationDialog(
                                confirmationDialogData: ConfirmationDialogData(
                                    title: 'Deletion',
                                    cancelTitle: 'Cancel',
                                    description:
                                        'Are you sure you want to delete ${lecture.title}.',
                                    acceptTitle: 'Yes')));
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Delete'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getlectureType(LectureType type) {
    if (type == LectureType.exercise) {
      return 'Excercise';
    } else {
      return 'Lecture';
    }
  }
}

/**
 * 
 * 
 * Container(
                child: ListView.builder(
                    itemCount: lecture.dates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(lecture.dates[index].room),
                          Text(lecture.dates[index].starting_time),
                          Text(lecture.dates[index].ending_time),
                        ],
                      );
                    }),
              )
 */