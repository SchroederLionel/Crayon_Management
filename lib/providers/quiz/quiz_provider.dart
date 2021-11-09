import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final List<Quiz> _quizes = <Quiz>[];

  int lengthOfQuizes() {
    return _quizes.length;
  }

  addQuiz(Quiz quiz) {
    _quizes.add(quiz);
    notifyListeners();
  }

  removeQuiz(Quiz quiz) {
    _quizes.remove(quiz);
    notifyListeners();
  }

  Quiz getQuiz(int index) => _quizes[index];
}
