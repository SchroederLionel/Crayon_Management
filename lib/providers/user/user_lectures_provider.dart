import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter/material.dart';

class UserLectureProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  setNotifierState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  List<LectureSnipped> _lectureSnipped = [];

  void removeLecture(LectureSnipped snipped) {
    setNotifierState(NotifierState.loading);
    LectureService.deleteLecture(snipped);
    _lectureSnipped.remove(snipped);
    setNotifierState(NotifierState.loaded);
  }

  void addLecture(Lecture lecture) {
    setNotifierState(NotifierState.loading);
    _lectureSnipped.add(lecture.getLectureSnipped);
    LectureService.addLecture(lecture);
    setNotifierState(NotifierState.loaded);
  }

  List<LectureSnipped> get lectures => _lectureSnipped;
  void setLectures(List<LectureSnipped> lectureSnipped) {
    _lectureSnipped = lectureSnipped;
    notifyListeners();
  }
}
