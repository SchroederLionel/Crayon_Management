import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/lecture_info_card.dart';
import 'package:crayon_management/screens/dashboard/components/time_picker.dart';
import 'package:flutter/material.dart';

class Lectures extends StatelessWidget {
  const Lectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Lectures',
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
                          title: Text(
                            'Add Lecture',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          content: Column(
                            children: [
                              Form(
                                  child: Column(
                                children: [
                                  TextField(
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            size: 18,
                                          ),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Title')),
                                  TextField(
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            size: 18,
                                          ),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Day ex.Monday')),
                                  CustomTimePicker(),
                                ],
                              ))
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(Icons.add),
                label: Text('Add Lecture')),
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
