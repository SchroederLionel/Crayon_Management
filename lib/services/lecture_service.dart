import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/lecture.dart';
import 'package:uuid/uuid.dart';

class LectureService {
  static void postLecture(
      String uid, String title, List<LectureDate> lectureDates) async {
    String fileUid = const Uuid().v4();
    Lecture lecture =
        Lecture(id: fileUid, title: title, lectureDates: lectureDates);

    lecture.setUid(uid);
    await FirebaseFirestore.instance
        .collection('lectures')
        .doc(fileUid)
        .set(lecture.toJson());

    List<Map> list = [];
    list.add(lecture.toJsonForUser());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'myLectures': FieldValue.arrayUnion(list)});
  }

  static void deleteService(Lecture lecture) {}
}
