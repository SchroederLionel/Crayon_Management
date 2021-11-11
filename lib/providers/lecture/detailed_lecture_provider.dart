import 'dart:html';

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class DetailedLectureProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<Failure, Lecture?> _lecture;

  Either<Failure, Lecture?> get lecture => _lecture;
  void _setLecture(Either<Failure, Lecture?> lecture) {
    _lecture = lecture;
  }

  void getLecture(String lectureId) async {
    _setState(NotifierState.loading);
    await Task(() => LectureService.getLecture(lectureId))
        .attempt()
        .map(
          (either) => either.leftMap((obj) {
            try {
              return obj as Failure;
            } catch (e) {
              throw obj;
            }
          }),
        )
        .run()
        .then((lecture) => _setLecture(lecture));

    _setState(NotifierState.loaded);
  }

  void removeSlide(String lectureID, Slide slide) async {
    await Task(() => LectureService.removeSlideFromLecture(lectureID, slide))
        .attempt()
        .map(
          (either) => either.leftMap((obj) {
            try {
              return obj as Failure;
            } catch (e) {
              throw obj;
            }
          }),
        )
        .run();
    lecture.fold((l) => 'removing-slide-not-working',
        (lecture) => lecture!.slides.remove(slide));
    notifyListeners();
  }

  void addSlide(Slide slide) {
    lecture.fold((l) => 'adding-slide-not-working',
        (lecture) => lecture!.slides.add(slide));
    notifyListeners();
  }
}
