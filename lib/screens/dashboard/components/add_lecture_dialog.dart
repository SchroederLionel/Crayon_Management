import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_date.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:crayon_management/screens/dashboard/components/time_picker.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddLectureDialog extends StatefulWidget {
  final UserData? userData;
  const AddLectureDialog({required this.userData, Key? key}) : super(key: key);

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
    var appTranslation = AppLocalizations.of(context);

    final lectureProvider =
        Provider.of<LectureDateProvider>(context, listen: false);

    final dropDownDayProvider =
        Provider.of<DropDownDayProvider>(context, listen: false);

    return AlertDialog(
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black26)),
              onPressed: () => Navigator.pop(context),
              child: Text(appTranslation!.translate('cancel') ?? 'Cancel')),
          ElevatedButton(
              onPressed: () {
                String fileUid = const Uuid().v4();

                final lecture = Lecture(
                  id: fileUid,
                  uid: uid as String,
                  title: _titleController.text,
                );
                lecture.setLectureDates(lectureProvider.getLectureDates);

                Navigator.pop(context, lecture);
              },
              child: Text(appTranslation.translate('upload') ?? 'Upload'))
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
                      appTranslation.translate('addLecture') ?? 'Add Lecture',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                            validator: (text) =>
                                ValidatorService.isStringLengthAbove2(
                                    _titleController.text, appTranslation),
                            onChanged: (String text) {},
                            controller: _titleController,
                            icon: Icons.title,
                            labelText:
                                appTranslation.translate('title') ?? 'Title',
                            isPassword: false),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: CustomTextFormField(
                                  validator: (text) =>
                                      ValidatorService.isStringLengthAbove2(
                                          _roomController.text, appTranslation),
                                  onChanged: (String text) {},
                                  controller: _roomController,
                                  icon: Icons.room,
                                  labelText: appTranslation.translate('room') ??
                                      'Room',
                                  isPassword: false),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 25),
                                child: Consumer<DropDownDayProvider>(
                                  builder: (context, dropProvider, __) {
                                    if (dropProvider.state ==
                                        NotifierState.initial) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) =>
                                              dropDownDayProvider.setUp(null));

                                      return Container();
                                    }

                                    return DropdownButton<String>(
                                        onChanged: (String? day) {
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
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(appTranslation
                                                    .translate(value) ??
                                                value),
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
                                      child: Text(
                                          appTranslation.translate(value) ??
                                              'error'),
                                    );
                                  }).toList()),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTimePicker(
                              timeText: appTranslation.translate('starts') ??
                                  'Starts',
                            ),
                            CustomTimePicker(
                              timeText:
                                  appTranslation.translate('ends') ?? 'Ends',
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
                              day: dropDownDayProvider.currentWeekDay!,
                              startingTime:
                                  timePickerProvider.getStartingTimeInString(),
                              endingTime:
                                  timePickerProvider.getEndingTimeInString(),
                              type: currentLectureType);
                          lectureProvider.add(date);
                        },
                        icon: const Icon(Icons.add),
                        label: Text(
                          appTranslation.translate('add-time-interval') ??
                              'Add time interval',
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    Flexible(
                      child: Consumer<LectureDateProvider>(
                        builder: (context, lectureInfo, child) {
                          if (lectureInfo.getLectureLength != 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: lectureInfo.getLectureLength,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(lectureInfo
                                          .getLectureDate(index)
                                          .room),
                                      Text(lectureInfo
                                          .getLectureDate(index)
                                          .day),
                                      Text(lectureInfo
                                          .getLectureDate(index)
                                          .startingTime),
                                      Text(lectureInfo
                                          .getLectureDate(index)
                                          .endingTime),
                                      Text(lectureInfo
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
