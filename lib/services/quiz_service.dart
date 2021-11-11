import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';

class QuizService {
  static Future<Quiz> addQuiz(String lectureId, Quiz quiz) async {
    try {
      List<Map> list = [];

      list.add(quiz.toJson());
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('quizes')
          .set(
              {'quizes': FieldValue.arrayUnion(list)}, SetOptions(merge: true));

      return quiz;
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

  static Future<List<Quiz>> getQuizes(String lectureId) async {
    try {
      List<Quiz> quizes = [];
      var quizDocument = await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('quizes')
          .get();
      //Lecture.fromJson(lectureDocument.data());
      if (quizDocument.exists) {
        if (quizDocument.data() != null) {
          if (quizDocument.data()!.containsKey('quizes')) {
            List.from(quizDocument.data()!['quizes'])
                .forEach((element) => quizes.add(Quiz.fromJson(element)));
          }
        }
      }

      return quizes;
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

  static Future<Quiz> removeQuiz(String lectureId, Quiz quiz) async {
    try {
      List<Map> list = [];
      list.add(quiz.toJson());
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('quizes')
          .update({'quizes': FieldValue.arrayRemove(list)});

      return quiz;
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
