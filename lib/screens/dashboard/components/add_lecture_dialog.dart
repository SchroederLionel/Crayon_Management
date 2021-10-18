import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/providers/lecture_provider.dart';
import 'package:crayon_management/providers/time_picker_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crayon_management/screens/dashboard/components/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLectureDialog extends StatefulWidget {
  const AddLectureDialog({Key? key}) : super(key: key);

  @override
  _AddLectureDialogState createState() => _AddLectureDialogState();
}

class _AddLectureDialogState extends State<AddLectureDialog> {
  late TextEditingController _titleController;
  late TextEditingController _roomController;
  String currentValueDay = 'monday';
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
        Provider.of<LectureProvider>(context, listen: false);
    return AlertDialog(
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black26)),
              onPressed: () => Navigator.pop(context),
              child: Text(translation!.cancel)),
          ElevatedButton(onPressed: () {}, child: Text(translation.upload))
        ],
        content: Provider<TimePickerProvider>(
          create: (context) => TimePickerProvider(),
          child: Builder(
            builder: (context) {
              return Container(
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
                                    prefixIcon: Icon(
                                      Icons.title,
                                      size: 18,
                                    ),
                                    border: UnderlineInputBorder(),
                                    labelText: translation.title))),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: TextField(
                                  controller: _roomController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.room,
                                        size: 18,
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'Room')),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: DropdownButton<String>(
                                  onChanged: (String? day) {
                                    setState(() {
                                      currentValueDay = day!;
                                    });
                                  },
                                  value: currentValueDay,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  icon: const Icon(Icons.arrow_drop_down),
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
                                    return DropdownMenuItem<String>(
                                      onTap: () {
                                        setState(() {
                                          currentValueDay = value;
                                        });
                                      },
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
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
                        SizedBox(
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
                              day: currentValueDay,
                              starting_time:
                                  timePickerProvider.getStartingTimeInString(),
                              ending_time:
                                  timePickerProvider.getEndingTimeInString(),
                              type: currentLectureType);
                          lectureProvider.add(date);
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add time interval')),
                    Flexible(
                      child: Consumer<LectureProvider>(
                        builder: (context, lecture_info, child) {
                          if (lecture_info.getLectureLength != 0) {
                            return ListView.builder(
                              itemCount: lecture_info.getLectureLength,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(lecture_info
                                        .getLectureDate(index)
                                        .room),
                                    Text(
                                        lecture_info.getLectureDate(index).day),
                                    Text(lecture_info
                                        .getLectureDate(index)
                                        .starting_time),
                                    Text(lecture_info
                                        .getLectureDate(index)
                                        .ending_time),
                                    Text(lecture_info
                                        .getLectureDate(index)
                                        .type
                                        .toString())
                                  ],
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
