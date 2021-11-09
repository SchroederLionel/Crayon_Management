import 'package:flutter/material.dart';

class TimePickerProvider {
  TimeOfDay _startingTime = TimeOfDay.now();
  TimeOfDay _endingTime = TimeOfDay.now();

  void _changeStartingTime(TimeOfDay time) {
    _startingTime = time;
  }

  void changeTime(String timeType, TimeOfDay time) {
    if (timeType.toLowerCase().contains('ends')) {
      _changeEndingTime(time);
    } else {
      _changeStartingTime(time);
    }
  }

  void _changeEndingTime(TimeOfDay time) {
    _endingTime = time;
  }

  TimeOfDay get getStaratingTime => _startingTime;
  TimeOfDay get getEndingTime => _endingTime;

  String getStartingTimeInString() {
    return getConvertedTime(_startingTime.hour) +
        ':' +
        getConvertedTime(_startingTime.minute);
  }

  String getEndingTimeInString() {
    return getConvertedTime(_endingTime.hour) +
        ':' +
        getConvertedTime(_endingTime.minute);
  }

  String getConvertedTime(int time) {
    if (time < 10) {
      return '0$time';
    } else {
      return '$time';
    }
  }
}
