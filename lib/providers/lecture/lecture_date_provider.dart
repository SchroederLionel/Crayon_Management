import 'package:crayon_management/datamodels/lecture/lecture_date.dart';
import 'package:flutter/cupertino.dart';

class LectureDateProvider extends ChangeNotifier {
  final List<LectureDate> _lecture = [];
  int get getLectureLength => _lecture.length;
  LectureDate getLectureDate(int index) => _lecture[index];
  List<LectureDate> get getLectureDates => _lecture;
  void add(LectureDate lectureDate) {
    _lecture.add(lectureDate);
    notifyListeners();
  }

  void remove(LectureDate lectureDate) {
    _lecture.remove(lectureDate);
    notifyListeners();
  }
}
