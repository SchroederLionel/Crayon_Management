import 'package:crayon_management/datamodels/lecture/custom_time_of_day.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTimePicker extends StatefulWidget {
  final CustomTimeOfDay day;
  final String timeText;
  final bool isDayTime;
  const CustomTimePicker(
      {required this.day,
      required this.isDayTime,
      required this.timeText,
      Key? key})
      : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late CustomTimeOfDay time;
  late CustomTimeOfDay? picked;
  late String timeText;

  @override
  void initState() {
    super.initState();
    timeText = widget.timeText;
    time = widget.day;
  }

  @override
  Widget build(BuildContext context) {
    var timePickerProvider =
        Provider.of<TimePickerProvider>(context, listen: false);
    String text = '$timeText: ${widget.day.toString()}';

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.alarm),
          onPressed: () async {
            TimeOfDay? picked =
                await showTimePicker(context: context, initialTime: time);
            if (picked != null) {
              time = CustomTimeOfDay(hour: picked.hour, minute: picked.minute);
              if (widget.isDayTime) {
                timePickerProvider.setStartingTime(time);
              } else {
                timePickerProvider.setEndingTime(time);
              }
            }
          },
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  String getConvertedTime(int time) {
    if (time < 10) {
      return '0$time';
    } else {
      return '$time';
    }
  }
}
