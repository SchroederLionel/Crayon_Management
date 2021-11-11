// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LectureService {
  static Future<Lecture> addLecture(Lecture lecture) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lecture.id)
          .set(lecture.toJson());
      List<Map> list = [];
      LectureSnipped snipped = lecture.getLectureSnipped;
      list.add(snipped.toJson());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(lecture.uid)
          .update({'myLectures': FieldValue.arrayUnion(list)});
      return lecture;
    } on FirebaseException catch (error) {
      throw Failure(code: error.code);
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  static void deleteLecture(
      LectureSnipped lectureSnipped, String userID) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureSnipped.id)
          .delete();

      List<Map> list = [];
      list.add(lectureSnipped.toJson());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .update({'myLectures': FieldValue.arrayRemove(list)});
    } on FirebaseException catch (error) {
      throw Failure(code: error.code);
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  static Future<Slide> addPdfToLecture(
      String lectureId, Slide slide, html.File file) async {
    final destination = 'slides/${slide.fileId}';
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putBlob(file);
      String url = await ref.getDownloadURL();
      slide.setUrl(url);
      List<Map> list = [];
      list.add(slide.toJson());

      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .update({'slides': FieldValue.arrayUnion(list)});
      return slide;
    } on FirebaseException catch (error) {
      throw Failure(code: error.code);
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  static Future<Lecture?> getLecture(String lectureId) async {
    try {
      Lecture lecture;
      var lectureDocument = await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .get();

      if (lectureDocument.exists) {
        lecture = Lecture.fromJson(lectureDocument.data());
      } else {
        throw Failure(code: 'lecture-not-exists');
      }
      return lecture;
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  static Future<Uint8List?> getSilde(String fileName) async {
    return FirebaseStorage.instance
        .refFromURL('gs://crayon-33cdc.appspot.com/slides')
        .child(fileName)
        .getData();
  }

  static Future<Slide> removeSlideFromLecture(
      String lectureId, Slide slide) async {
    List<Map> list = [];

    list.add(slide.toJson());

    final destination = 'slides/${slide.fileId}';
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      ref.delete();

      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .update({'slides': FieldValue.arrayRemove(list)});

      return slide;
    } on FirebaseException catch (error) {
      throw Failure(code: error.code);
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }
}
