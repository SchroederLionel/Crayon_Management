import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<Failure, List<Quiz>> _quizes;
  void _setQuizes(Either<Failure, List<Quiz>> quizes) {
    _quizes = quizes;
  }

  Either<Failure, List<Quiz>> get quizes => _quizes;

  addQuiz(String lectureId, Quiz quiz) async {
    _setState(NotifierState.loading);
    await Task(() => QuizService.addQuiz(lectureId, quiz))
        .attempt()
        .map((either) => either.leftMap((obj) {
              try {
                return obj as Failure;
              } catch (e) {
                throw obj;
              }
            }))
        .run();
    _addQuiz(quiz);
    _setState(NotifierState.loaded);
  }

  void _addQuiz(Quiz quiz) {
    _quizes.fold((l) => null, (quizes) => quizes.add(quiz));
  }

  removeQuiz(String lectureId, Quiz quiz) async {
    _setState(NotifierState.loading);
    await Task(() => QuizService.removeQuiz(lectureId, quiz))
        .attempt()
        .map((either) => either.leftMap((obj) {
              try {
                return obj as Failure;
              } catch (e) {
                throw obj;
              }
            }))
        .run();
    _removeQuiz(quiz);
    _setState(NotifierState.loaded);
  }

  void _removeQuiz(Quiz quiz) {
    _quizes.fold((l) => null, (quizes) => quizes.remove(quiz));
  }

  void getQuizes(String lectureId) async {
    _setState(NotifierState.loading);
    Either<Failure, List<Quiz>> quizes =
        await Task(() => QuizService.getQuizes(lectureId))
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
    _setQuizes(quizes);
    _setState(NotifierState.loaded);
  }
}
