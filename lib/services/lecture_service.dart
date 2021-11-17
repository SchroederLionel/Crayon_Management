// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/datamodels/lecture/slide.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LectureService {
  static Future<LectureSnipped> addLecture(LectureSnipped lecture) async {
    try {
      Lecture l =
          Lecture(uid: uid as String, title: lecture.title, id: lecture.id);
      l.setLectureDates(lecture.lectureDates);
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lecture.id)
          .set(l.toJson());
      List<Map> list = [];
      LectureSnipped snipped =
          LectureSnipped(id: lecture.id, title: lecture.title);

      snipped.setLectureDates(lecture.lectureDates);

      list.add(snipped.toJson());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'myLectures': FieldValue.arrayUnion(list)});

      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lecture.id)
          .collection('features')
          .doc('questions')
          .set({'questions': []});

      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lecture.id)
          .collection('features')
          .doc('currentQuiz')
          .set({'currentQuiz': []});

      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lecture.id)
          .collection('features')
          .doc('quizes')
          .set({'quizes': []});

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

  static void deleteLecture(LectureSnipped lectureSnipped) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureSnipped.id)
          .delete();

      List<Map> list = [];
      list.add(lectureSnipped.toJson());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
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

  static Future<List<LectureSnipped>> updateLecture(
      LectureSnipped lecture, List<LectureSnipped> snippeds) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lecture.id)
          .set(lecture.toJson(), SetOptions(merge: true));

      List<Map> list = [];
      list.addAll(snippeds.map((dates) => dates.toJson()));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'myLectures': list}, SetOptions(merge: true));

      return snippeds;
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
