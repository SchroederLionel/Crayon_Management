import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/language/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DropDownDayProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  Language? _currentWeekDay;
  Language? get currentWeekDay => _currentWeekDay;
  late List<Language> _weekDays;
  List<Language> get weekDays => _weekDays;

  void setWeekDay(Language weekday) {
    _currentWeekDay = weekday;
    notifyListeners();
  }

  void setUp(BuildContext context) {
    var translation = AppLocalizations.of(
      context,
    );
    _weekDays = [
      Language(keyword: 'monday', translation: translation!.monday),
      Language(keyword: 'tuesday', translation: translation.tuesday),
      Language(keyword: 'wednesday', translation: translation.wednesday),
      Language(keyword: 'thursday', translation: translation.thursday),
      Language(keyword: 'firday', translation: translation.friday),
      Language(keyword: 'saturday', translation: translation.saturday),
      Language(keyword: 'sunday', translation: translation.sunday)
    ];

    _currentWeekDay = _weekDays.first;
    _state = NotifierState.loaded;
    notifyListeners();
  }
}
