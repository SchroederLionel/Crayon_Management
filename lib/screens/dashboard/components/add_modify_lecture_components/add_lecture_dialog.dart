import 'package:crayon_management/datamodels/lecture/lecture_date.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/drop_down_type_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:crayon_management/screens/dashboard/components/add_modify_lecture_components/components/drop_down_day.dart';
import 'package:crayon_management/screens/dashboard/components/add_modify_lecture_components/components/drop_down_type.dart';
import 'package:crayon_management/screens/dashboard/components/add_modify_lecture_components/components/time_interval.dart';
import 'package:crayon_management/screens/dashboard/components/add_modify_lecture_components/components/time_picker_buttons.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/cancel_button.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddLectureDialog extends StatefulWidget {
  final LectureSnipped? lectureSnipped;
  const AddLectureDialog({required this.lectureSnipped, Key? key})
      : super(key: key);

  @override
  _AddLectureDialogState createState() => _AddLectureDialogState();
}

class _AddLectureDialogState extends State<AddLectureDialog> {
  LectureSnipped? _lectureSnipped;
  late TextEditingController _titleController;
  late TextEditingController _roomController;

  @override
  void initState() {
    super.initState();
    _lectureSnipped = widget.lectureSnipped;
    if (_lectureSnipped != null) {
      _titleController = TextEditingController(text: _lectureSnipped!.title);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Provider.of<LectureDateProvider>(context, listen: false)
            .setLectureDates(_lectureSnipped!.lectureDates);
      });
    } else {
      _titleController = TextEditingController(text: '');
    }

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
    var timePickerProvider =
        Provider.of<TimePickerProvider>(context, listen: false);
    var lectureTypeProvider =
        Provider.of<DropDownTypeProvider>(context, listen: false);

    return AlertDialog(
        actions: [
          const CancelButton(),
          ElevatedButton(
              onPressed: () {
                String fileUid;
                if (_lectureSnipped == null) {
                  fileUid = const Uuid().v4();
                } else {
                  fileUid = _lectureSnipped!.id;
                }

                final lecture = LectureSnipped(
                  id: fileUid,
                  title: _titleController.text,
                );
                lecture.setLectureDates(lectureProvider.getLectureDates);
                Navigator.pop(context, lecture);
              },
              child: Text(appTranslation!.translate('upload') ?? 'Upload'))
        ],
        content: SizedBox(
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
                      labelText: appTranslation.translate('title') ?? 'Title',
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
                            labelText:
                                appTranslation.translate('room') ?? 'Room',
                            isPassword: false),
                      ),
                      const DropDownDay(),
                      const DropDownType()
                    ],
                  ),
                  const TimePickerButtons(),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    LectureDate date = LectureDate(
                        room: _roomController.text,
                        day: dropDownDayProvider.currentWeekDay!,
                        startingTime: timePickerProvider.staratingTime,
                        endingTime: timePickerProvider.endingTime,
                        type: lectureTypeProvider.currentType);
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
              const TimeInterval()
            ],
          ),
        ));
  }
}
