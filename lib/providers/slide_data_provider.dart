import 'dart:html';

import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/services/lecture_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SlideDataProvider extends ChangeNotifier {
  String _title = '';

  late File _file;

  Color _currentColor = Colors.blueAccent;

  String get getTitle => _title;

  File? get getDroppedFile => _file;
  Color get currentColor => _currentColor;

  void updateValues(String title, File file, String fileType) {
    if (fileType.toUpperCase().contains('PDF')) {
      _currentColor = Colors.greenAccent;
      _file = file;
    } else {
      _title = 'Only PDF file type is accepted';
      _currentColor = Colors.redAccent;
    }
    notifyListeners();
  }

  Future<Either<Failure, Slide>> addSlide(String lectureID) async {
    String slideId = const Uuid().v4();
    Slide newSlide = Slide(fileId: slideId, title: _title);
    return await addPdf(lectureID, newSlide, _file);
  }

  Future<Either<Failure, Slide>> addPdf(
      String lectureID, Slide newSlide, File file) async {
    return await Task(
            () => LectureService.addPdfToLecture(lectureID, newSlide, file))
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
  }

  Future<Either<Failure, Slide>> removeSlide(
      String lectureID, Slide slide) async {
    return await Task(
            () => LectureService.removeSlideFromLecture(lectureID, slide))
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
  }

  void setTitle(String title) => _title = title;
  void setFile(File file) => _file = file;
}
