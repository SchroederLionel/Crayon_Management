import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter/material.dart';

class UserLectureProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  List<LectureSnipped> _lectureSnipped = [];
  NotifierState get state => _state;

  setNotifierState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void removeLecture(LectureSnipped snipped) {
    setNotifierState(NotifierState.loading);
    LectureService.deleteLecture(snipped);
    _lectureSnipped.remove(snipped);
    setNotifierState(NotifierState.loaded);
  }

  void addLecture(LectureSnipped lecture) async {
    setNotifierState(NotifierState.loading);
    await LectureService.addLecture(lecture);
    _lectureSnipped.add(lecture.getLectureSnipped);
    setNotifierState(NotifierState.loaded);
  }

  void updateLecture(LectureSnipped snipped) async {
    setNotifierState(NotifierState.loading);

    for (int i = 0; i < _lectureSnipped.length; i++) {
      if (_lectureSnipped[i].id == snipped.id) {
        _lectureSnipped[i] = snipped;

        break;
      }
    }
    await LectureService.updateLecture(snipped, _lectureSnipped);

    setNotifierState(NotifierState.loaded);
  }

  List<LectureSnipped> get lectures => _lectureSnipped;
  void setLectures(List<LectureSnipped> lectureSnipped) {
    _lectureSnipped = lectureSnipped;
    setNotifierState(NotifierState.loaded);
  }
}
