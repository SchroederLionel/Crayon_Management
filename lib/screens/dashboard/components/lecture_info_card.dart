import 'package:crayon_management/datamodels/lecture.dart';
import 'package:flutter/material.dart';

class LectureInfoCard extends StatelessWidget {
  final Lecture lecture;
  const LectureInfoCard({required this.lecture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                child: Text(
                  lecture.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              'Dates:',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Expanded(
              child: Container(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
