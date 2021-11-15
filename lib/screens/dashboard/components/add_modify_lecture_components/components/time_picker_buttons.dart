import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:crayon_management/screens/dashboard/components/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimePickerButtons extends StatelessWidget {
  const TimePickerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return Consumer<TimePickerProvider>(builder: (_, timePickerProvider, __) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTimePicker(
            day: timePickerProvider.staratingTime,
            isDayTime: true,
            timeText: appTranslation!.translate('starts') ?? 'Starts',
          ),
          CustomTimePicker(
            day: timePickerProvider.endingTime,
            isDayTime: false,
            timeText: appTranslation.translate('ends') ?? 'Ends',
          ),
        ],
      );
    });
  }
}
