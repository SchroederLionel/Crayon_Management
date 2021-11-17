import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_html/html.dart';
import 'package:uuid/uuid.dart';

class SlidesProvider extends ChangeNotifier {
  List<Slide> slides = [];

  SlidesProvider(Lecture lecture) {
    slides = lecture.slides;
  }

  int get getSlidesLength => slides.length;

  Slide getSlide(int index) => slides[index];

  List<Slide> get getSlides => slides;

  void removeSlide(String lectureID, Slide slide) {
    slides.remove(slide);
    LectureService.removeSlideFromLecture(lectureID, slide);
    notifyListeners();
  }

  void addSlide(String lectureID, String title, File file) {
    String slideId = const Uuid().v4();
    Slide newSlide = Slide(fileId: slideId, title: title);
    slides.add(newSlide);
    LectureService.addPdfToLecture(lectureID, newSlide, file);
    notifyListeners();
  }
}
