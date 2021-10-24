import 'package:crayon_management/datamodels/basic.dart';
import 'package:crayon_management/datamodels/lecture/lecture_date.dart';

class LectureSnipped extends Basic {
  String title = '';
  List<LectureDate> lectureDates = <LectureDate>[];
  LectureSnipped({required id, required this.title})
      : super(id: id, path: 'lectures');

  void setLectureDates(List<LectureDate> lectureDates) =>
      this.lectureDates = lectureDates;

  LectureSnipped get getLectureSnipped => this;

  factory LectureSnipped.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final title = json['title'] as String;
    // Cast to a nullable list as the lectureDates may be missing.
    final lectureData = json['lectureDates'] as List<dynamic>?;
    // if the lecture dates are not missing
    final lectureDates = lectureData != null
        ? lectureData
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];
    LectureSnipped lectureSnipped = LectureSnipped(
      id: id,
      title: title,
    );
    lectureSnipped.setLectureDates(lectureDates);
    return lectureSnipped;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'lectureDates': lectureDates.map((date) => date.toJson())
      };
}
