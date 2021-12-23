import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/quiz/quiz_result_user.dart';

class QuizUserResponsesSerivice {
  Future<List<QuizResultUser>> getResponsesFromUser(String lectureId) async {
    try {
      var json = await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('responses')
          .get();
      List? responseData = json.data()!['responses'];
      return responseData == null
          ? []
          : responseData
              .map((response) => QuizResultUser.fromJson(response))
              .toList();
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }
}
