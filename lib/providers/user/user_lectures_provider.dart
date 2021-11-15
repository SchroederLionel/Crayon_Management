import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
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

  void addLecture(Lecture lecture) async {
    setNotifierState(NotifierState.loading);
    await LectureService.addLecture(lecture);
    _lectureSnipped.add(lecture.getLectureSnipped);
    setNotifierState(NotifierState.loaded);
  }

  List<LectureSnipped> get lectures => _lectureSnipped;
  void setLectures(List<LectureSnipped> lectureSnipped) {
    _lectureSnipped = lectureSnipped;
    notifyListeners();
  }
}
