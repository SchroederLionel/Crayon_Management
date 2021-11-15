import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/drop_down_type_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeInterval extends StatelessWidget {
  const TimeInterval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropDownDayProvider =
        Provider.of<DropDownDayProvider>(context, listen: false);
    var dropDownTypeProvider =
        Provider.of<DropDownTypeProvider>(context, listen: false);
    var timePickerProvider =
        Provider.of<TimePickerProvider>(context, listen: false);
    return Flexible(
      child:
          Consumer<LectureDateProvider>(builder: (_, lectureDateProvider, __) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: lectureDateProvider.getLectureLength,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        dropDownTypeProvider.setCurrentType(
                            lectureDateProvider.getLectureDates[index].type);
                        dropDownDayProvider.setWeekDay(
                            lectureDateProvider.getLectureDates[index].day);
                        timePickerProvider.setStartingAndEndingTime(
                            lectureDateProvider
                                .getLectureDates[index].startingTime,
                            lectureDateProvider
                                .getLectureDates[index].endingTime);
                        lectureDateProvider
                            .remove(lectureDateProvider.getLectureDates[index]);
                      },
                      icon: const Icon(Icons.edit)),
                  Text(lectureDateProvider.getLectureDate(index).room),
                  Text(lectureDateProvider.getLectureDate(index).day),
                  Text(lectureDateProvider
                      .getLectureDate(index)
                      .startingTime
                      .toString()),
                  Text(lectureDateProvider
                      .getLectureDate(index)
                      .endingTime
                      .toString()),
                  Text(
                    lectureDateProvider.getLectureDate(index).type.toString(),
                  ),
                  IconButton(
                      onPressed: () {
                        lectureDateProvider
                            .remove(lectureDateProvider.getLectureDate(index));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ))
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
