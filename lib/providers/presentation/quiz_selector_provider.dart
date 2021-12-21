import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:flutter/material.dart';

class QuizSelectorProvider extends ChangeNotifier {
  String lectureId;
  late Quiz _currentQuiz;
  List<Quiz> quizes = [];

  QuizSelectorProvider({required this.quizes, required this.lectureId}) {
    _currentQuiz = quizes.first;
  }

  Quiz get currentQuiz => _currentQuiz;
  void changeQuiz(Quiz quiz) {
    if (quiz != _currentQuiz) {
      _currentQuiz = quiz;
      notifyListeners();
    }
  }

  int _seconds = 100;

  int get seconds => _seconds;

  void setSeconds(int seconds) => _seconds = seconds;
}
