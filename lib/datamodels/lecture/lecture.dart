import 'package:crayon_management/datamodels/lecture/lecture_date.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';

class Lecture extends LectureSnipped {
  String uid;
  bool isLobbyOpen;
  List<Slide> slides = <Slide>[];

  Lecture(this.isLobbyOpen, {required this.uid, required title, required id})
      : super(title: title, id: id);

  setSlides(List<Slide> slides) => this.slides = slides;

  setUid(String uid) => this.uid = uid;

  factory Lecture.fromJson(Map<String, dynamic>? json) {
    final uid = json!['uid'] as String;
    final id = json['id'] as String;
    final title = json['title'] as String;
    final isLobbyOpen = json['isLobbyOpen'] ?? false;

    final slidesData = json['slides'] as List<dynamic>?;
    final slides = slidesData != null
        ? slidesData.map((slide) => Slide.fromJson(slide)).toList()
        : <Slide>[];

    final lectureData = json['lectureDates'] as List<dynamic>?;
    final lecturesDates = lectureData != null
        ? lectureData
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];

    Lecture lecture = Lecture(isLobbyOpen, uid: uid, title: title, id: id);
    lecture.setSlides(slides);

    lecture.setLectureDates(lecturesDates);

    return lecture;
  }

  @override
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'title': title,
        'lectureDates':
            lectureDates.map((lectureDate) => lectureDate.toJson()).toList(),
        'slides': slides.map((slide) => slide.toJson()).toList(),
      };
}
