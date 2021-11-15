import 'package:crayon_management/datamodels/lecture/custom_time_of_day.dart';
import 'package:flutter/material.dart';

class TimePickerProvider extends ChangeNotifier {
  CustomTimeOfDay _startingTime = CustomTimeOfDay.now();
  CustomTimeOfDay _endingTime = CustomTimeOfDay.now();

  setStartingTime(CustomTimeOfDay day) {
    _startingTime = day;
    notifyListeners();
  }

  setEndingTime(CustomTimeOfDay day) {
    _endingTime = day;
    notifyListeners();
  }

  setStartingAndEndingTime(CustomTimeOfDay start, CustomTimeOfDay ends) {
    _startingTime = start;
    _endingTime = ends;
    notifyListeners();
  }

  CustomTimeOfDay get staratingTime => _startingTime;
  CustomTimeOfDay get endingTime => _endingTime;
}
