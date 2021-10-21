import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/lecture.dart';

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
}
