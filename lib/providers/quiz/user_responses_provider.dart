import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/datamodels/quiz/quiz_response_user.dart';
import 'package:crayon_management/datamodels/quiz/quiz_result_user.dart';

import 'package:crayon_management/services/quiz_user_responses_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UserResponsesProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  late Either<Failure, List<QuizResultUser>> _quizResponses;
  Either<Failure, List<QuizResultUser>>? get quizResponses => _quizResponses;

  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void getUserResponses(String lectureId) async {
    setState(NotifierState.loading);
    QuizUserResponsesSerivice service = QuizUserResponsesSerivice();
    service.getResponsesFromUser(lectureId);
    _quizResponses = await Task(() => service.getResponsesFromUser(lectureId))
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
    setState(NotifierState.loaded);
  }

  Map<String, int> getHowManyGotQuestionRightAndWrong(
      String question, List<QuizResultUser> responses) {
    int howManyTrue = 0;
    int howManyFalse = 0;
    for (QuizResultUser response in responses) {
      bool didTheQuesitonRight = false;
      for (QuizResponse qres in response.responses) {
        if (qres.question.toLowerCase().trim() ==
            question.toLowerCase().trim()) {
          didTheQuesitonRight = true;
          break;
        }
      }
      didTheQuesitonRight == true ? howManyTrue += 1 : howManyFalse += 1;
    }

    return {"right": howManyTrue, "wrong": howManyFalse};
  }

  int getMaxScore(Quiz quiz, int timeAvailable) {
    return (quiz.questions.length * 20 +
            (timeAvailable - quiz.questions.length) * 2) *
        quiz.questions.length;
  }
}
