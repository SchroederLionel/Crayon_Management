import 'dart:html';

import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class DetailedLectureProvider extends ChangeNotifier {
  Lecture? lecture;

  bool isLoading = false;

  getLectureData(String lectureId) async {
    isLoading = true;
    var data = await LectureService.getLecture(lectureId);

    if (data != null) {
      lecture = data;
    }

    isLoading = false;
    notifyListeners();
  }

  void removeSlide(String lectureID, Slide slide) {
    lecture!.slides.remove(slide);
    LectureService.removeSlideFromLecture(lectureID, slide);
    notifyListeners();
  }

  void addSlide(String lectureID, String title, File file) {
    String slideId = const Uuid().v4();
    Slide newSlide = Slide(fileId: slideId, title: title);
    lecture!.slides.add(newSlide);
    LectureService.addPdfToLecture(lectureID, newSlide, file);
    notifyListeners();
  }
}
