import 'dart:typed_data';

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class PresentationProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<Failure, Uint8List?> _slides;
  Either<Failure, Uint8List?> get slide => _slides;
  void _setSlide(Either<Failure, Uint8List?> slides) => _slides = slides;

  void getSlide(String fileName) async {
    _setState(NotifierState.loading);
    await Task(() => LectureService.getSilde(fileName))
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
        .then((slides) => _setSlide(slides));

    _setState(NotifierState.loaded);
  }
}
