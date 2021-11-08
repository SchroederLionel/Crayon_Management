import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/language/language.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_date.dart';

import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';

import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crayon_management/screens/dashboard/components/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddLectureDialog extends StatefulWidget {
  const AddLectureDialog({Key? key}) : super(key: key);

  @override
  _AddLectureDialogState createState() => _AddLectureDialogState();
}

class _AddLectureDialogState extends State<AddLectureDialog> {
  late TextEditingController _titleController;
  late TextEditingController _roomController;

  String currentLectureType = 'lecture';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _roomController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);

    final lectureProvider =
        Provider.of<LectureDateProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final dropDownDayProvider =
        Provider.of<DropDownDayProvider>(context, listen: false);

    return AlertDialog(
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black26)),
              onPressed: () => Navigator.pop(context),
              child: Text(translation!.cancel)),
          ElevatedButton(
              onPressed: () {
                String fileUid = const Uuid().v4();

                final lecture = Lecture(
                  id: fileUid,
                  uid: userProvider.getUserId,
                  title: _titleController.text,
                );
                lecture.setLectureDates(lectureProvider.getLectureDates);
                LectureService.addLecture(lecture);
                userProvider.addLecture(lecture);
                Navigator.pop(context);
              },
              child: Text(translation.upload))
        ],
        content: Provider<TimePickerProvider>(
          create: (context) => TimePickerProvider(),
          child: Builder(
            builder: (context) {
              return SizedBox(
                height: 630,
                width: 550,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      translation.addLecture,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                            child: TextField(
                                style: Theme.of(context).textTheme.bodyText1,
                                controller: _titleController,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.title,
                                      size: 18,
                                    ),
                                    border: const UnderlineInputBorder(),
                                    labelText: translation.title))),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextField(
                                  controller: _roomController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.room,
                                        size: 18,
                                      ),
                                      border: const UnderlineInputBorder(),
                                      labelText: translation.room)),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 25),
                                child: Consumer<DropDownDayProvider>(
                                  builder: (context, dropProvider, __) {
                                    if (dropProvider.state ==
                                        NotifierState.initial) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) =>
                                              dropDownDayProvider
                                                  .setUp(context));

                                      return Container();
                                    }

                                    return DropdownButton<Language>(
                                        onChanged: (Language? day) {
                                          if (day != null) {
                                            dropProvider.setWeekDay(day);
                                          }
                                        },
                                        value: dropProvider.currentWeekDay,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        underline: Container(
                                          height: 2,
                                          color: Colors.blueAccent,
                                        ),
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 18,
                                        items: dropProvider.weekDays
                                            .map<DropdownMenuItem<Language>>(
                                                (Language value) {
                                          return DropdownMenuItem<Language>(
                                            value: value,
                                            child: Text(value.translation),
                                          );
                                        }).toList());
                                  },
                                )),
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: DropdownButton<String>(
                                  value: currentLectureType,
                                  onChanged: (String? type) {
                                    setState(() {
                                      currentLectureType = type!;
                                    });
                                  },
                                  style: Theme.of(context).textTheme.bodyText1,
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 18,
                                  items: <String>[
                                    'lecture',
                                    'exercise',
                                    'other',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTimePicker(
                              timeText: translation.starts,
                            ),
                            CustomTimePicker(
                              timeText: translation.ends,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          var timePickerProvider =
                              Provider.of<TimePickerProvider>(context,
                                  listen: false);
                          LectureDate date = LectureDate(
                              room: _roomController.text,
                              day: dropDownDayProvider.currentWeekDay!.keyword,
                              startingTime:
                                  timePickerProvider.getStartingTimeInString(),
                              endingTime:
                                  timePickerProvider.getEndingTimeInString(),
                              type: currentLectureType);
                          lectureProvider.add(date);
                        },
                        icon: const Icon(Icons.add),
                        label: Text('Add time interval')),
                    const SizedBox(
                      height: 14,
                    ),
                    Flexible(
                      child: Consumer<LectureDateProvider>(
                        builder: (context, lecture_info, child) {
                          if (lecture_info.getLectureLength != 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: lecture_info.getLectureLength,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(lecture_info
                                          .getLectureDate(index)
                                          .room),
                                      Text(lecture_info
                                          .getLectureDate(index)
                                          .day),
                                      Text(lecture_info
                                          .getLectureDate(index)
                                          .startingTime),
                                      Text(lecture_info
                                          .getLectureDate(index)
                                          .endingTime),
                                      Text(lecture_info
                                          .getLectureDate(index)
                                          .type
                                          .toString())
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
