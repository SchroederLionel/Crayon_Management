import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';

class QuestionService {
  static Stream<List<String>> getQuestionSnapshots(String lectureId) {
    try {
      return FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('questions')
          .snapshots()
          .map((snapShot) {
        try {
          return List<String>.from(snapShot.data()!['questions']);
        } catch (e) {
          throw Failure(code: '');
        }
      });
    } catch (e) {}
    throw Failure(code: '');
  }

  static Stream<List<String>> removeQuestion(
      String lectureId, List<String> questions) {
    try {
      FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('questions')
          .update({'questions': FieldValue.arrayRemove(questions)});
    } catch (e) {}
    throw Failure(code: '');
  }
}
