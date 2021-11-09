import 'package:crayon_management/datamodels/enum.dart';
import 'package:flutter/material.dart';

class DropDownDayProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  String? _currentWeekDay;
  String? get currentWeekDay => _currentWeekDay;
  final List<String> _weekDays = const [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'firday',
    'saturday',
    'sunday',
  ];
  List<String> get weekDays => _weekDays;

  void setWeekDay(String weekday) {
    _currentWeekDay = weekday;
    notifyListeners();
  }

  void setUp(String? currentDay) {
    _currentWeekDay = currentDay ?? _weekDays.first;
    _state = NotifierState.loaded;
    notifyListeners();
  }
}
