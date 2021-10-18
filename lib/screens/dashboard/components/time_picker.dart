import 'package:crayon_management/providers/time_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTimePicker extends StatefulWidget {
  String timeText;
  CustomTimePicker({required this.timeText, Key? key}) : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay time;
  late TimeOfDay? picked;
  late String timeText;
  late TimePickerProvider timePickerProvider;

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    timeText = widget.timeText;
    timePickerProvider =
        Provider.of<TimePickerProvider>(context, listen: false);
  }

  Future selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);

    if (picked != null) {
      setState(() {
        time = picked!;
        timePickerProvider.changeTime(timeText, time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.alarm),
          onPressed: () {
            selectTime(context);
          },
        ),
        Text(
          '$timeText: ${getConvertedTime(time.hour)}: ${getConvertedTime(time.minute)}',
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
