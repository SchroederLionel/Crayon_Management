import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/lecture_info_card.dart';
import 'package:crayon_management/screens/dashboard/components/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Lectures extends StatelessWidget {
  const Lectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    String currentValue = 'monday';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translation!.myLectures,
              style: Theme.of(context).textTheme.headline2,
            ),
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical:
                            14.0 / (Responsive.isMobile(context) ? 2 : 1))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black26)),
                                onPressed: () => Navigator.pop(context),
                                child: Text(translation.cancel)),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(translation.upload))
                          ],
                          content: Builder(
                            builder: (context) {
                              return Container(
                                height: 630,
                                width: 550,
                                child: Column(
                                  children: [
                                    Text(
                                      translation.addLecture,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    Form(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.title,
                                                  size: 18,
                                                ),
                                                border: UnderlineInputBorder(),
                                                labelText: translation.title)),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            DropdownButton<String>(
                                                onChanged: (String? e) {
                                                  currentValue = e!;
                                                },
                                                value: currentValue,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.blueAccent,
                                                ),
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 18,
                                                items: <String>[
                                                  'monday',
                                                  'tuesday',
                                                  'wednesday',
                                                  'thursday',
                                                  'friday',
                                                  'saturday',
                                                  'sunday'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()),
                                            DropdownButton<String>(
                                                value: 'lecture',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.blueAccent,
                                                ),
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 18,
                                                items: <String>[
                                                  'lecture',
                                                  'exercise',
                                                  'other',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()),
                                            CustomTimePicker(
                                              timeText: translation.starts,
                                            ),
                                            CustomTimePicker(
                                              timeText: translation.ends,
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 16,
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      });
                },
                icon: Icon(Icons.add),
                label: Text(translation.addLecture)),
          ],
        ),
      ],
    );
  }
}

class LectureInfoCardGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  LectureInfoCardGridView(
      {Key? key, this.crossAxisCount = 4, this.childAspectRatio = 1.5})
      : super(key: key);

  final lectures = [
    Lecture(
        id: '1',
        pid: 'PID',
        title: 'Operating Systems',
        lastPowerPointTitle: 'Introduction',
        dates: [
          LectureDate(
              room: 'B112',
              day: 'monday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.exercise),
          LectureDate(
              room: 'B112',
              day: 'monday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.lecture)
        ]),
    Lecture(
        id: '2',
        pid: 'PID',
        title: 'Hardwarenahe Softwareentwicklung',
        lastPowerPointTitle: 'Introduction',
        dates: [
          LectureDate(
              room: 'B112',
              day: 'Tuesday',
              starting_time: '10:30',
              ending_time: '12:00',
              type: LectureType.exercise),
          LectureDate(
              room: 'B112',
              day: 'friday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.lecture)
        ]),
    Lecture(
        id: '3',
        pid: 'PID',
        title: 'Programming',
        lastPowerPointTitle: 'Introduction',
        dates: [
          LectureDate(
              room: 'B112',
              day: 'Tuesday',
              starting_time: '10:30',
              ending_time: '12:00',
              type: LectureType.exercise),
          LectureDate(
              room: 'B112',
              day: 'friday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.lecture)
        ]),
    Lecture(
        id: '3',
        pid: 'PID',
        title: 'Programming',
        lastPowerPointTitle: 'Introduction',
        dates: [
          LectureDate(
              room: 'B112',
              day: 'Tuesday',
              starting_time: '10:30',
              ending_time: '12:00',
              type: LectureType.exercise),
          LectureDate(
              room: 'B112',
              day: 'friday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.lecture)
        ]),
    Lecture(
        id: '3',
        pid: 'PID',
        title: 'Programming',
        lastPowerPointTitle: 'Introduction',
        dates: [
          LectureDate(
              room: 'B112',
              day: 'Tuesday',
              starting_time: '10:30',
              ending_time: '12:00',
              type: LectureType.exercise),
          LectureDate(
              room: 'B112',
              day: 'friday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.lecture)
        ]),
    Lecture(
        id: '3',
        pid: 'PID',
        title: 'Programming',
        lastPowerPointTitle: 'Introduction',
        dates: [
          LectureDate(
              room: 'B112',
              day: 'Tuesday',
              starting_time: '10:30',
              ending_time: '12:00',
              type: LectureType.exercise),
          LectureDate(
              room: 'B112',
              day: 'friday',
              starting_time: '12:30',
              ending_time: '15:00',
              type: LectureType.lecture)
        ])
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        return LectureInfoCard(
          lecture: lectures[index],
        );
      },
    );
  }
}
