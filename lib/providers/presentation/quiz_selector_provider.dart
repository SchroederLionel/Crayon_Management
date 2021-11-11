import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:flutter/material.dart';

class QuizSelectorProvider extends ChangeNotifier {
  late Quiz _currentQuiz;
  List<Quiz> quizes;

  QuizSelectorProvider({required this.quizes}) {
    _currentQuiz = quizes.first;
  }

  Quiz get currentQuiz => _currentQuiz;

  changeQuiz(Quiz quiz) {
    _currentQuiz = quiz;
    notifyListeners();
  }
}
