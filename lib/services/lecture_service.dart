// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/lecture.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LectureService {
  static void postLecture(Lecture lecture) async {
    await FirebaseFirestore.instance
        .collection('lectures')
        .doc(lecture.id)
        .set(lecture.toJson());

    List<Map> list = [];
    list.add(lecture.toJsonForUser());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(lecture.uid)
        .update({'myLectures': FieldValue.arrayUnion(list)});
  }

  static void deleteService(Lecture lecture) async {
    await FirebaseFirestore.instance
        .collection('lectures')
        .doc(lecture.id)
        .delete();

    List<Map> list = [];
    list.add(lecture.toJsonForUser());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(lecture.uid)
        .update({'myLectures': FieldValue.arrayRemove(list)});
  }

  static void addPdfToLecture(String lectureId, Slide slide, File file) async {
    final destination = 'slides/${slide.fileId}';
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      ref.putBlob(file);
    } on FirebaseException catch (e) {}

    List<Map> list = [];
    list.add(slide.toJson());
    await FirebaseFirestore.instance
        .collection('lectures')
        .doc(lectureId)
        .update({'slides': FieldValue.arrayUnion(list)});
  }

  static Future<Lecture?> getLecture(String lectureId) async {
    Lecture? lecture;

    var lectureDocument = await FirebaseFirestore.instance
        .collection('lectures')
        .doc(lectureId)
        .get();

    if (lectureDocument.exists) {
      lecture = Lecture.fromJson(lectureDocument.data());
    }

    return lecture;
  }

  static void removeSlideFromLecture(String lectureId, Slide slide) async {
    List<Map> list = [];
    list.add(slide.toJson());

    final destination = 'slides/${slide.fileId}';
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      ref.delete();
    } on FirebaseException catch (e) {}
    await FirebaseFirestore.instance
        .collection('lectures')
        .doc(lectureId)
        .update({'slides': FieldValue.arrayRemove(list)});
  }
}
