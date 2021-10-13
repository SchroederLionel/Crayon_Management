import 'package:crayon_management/providers/quiz_provider.dart';
import 'package:flutter/cupertino.dart';

class QuizListProvider extends ChangeNotifier {
  List<QuizProvider> quizQuestions = [];

  int get getQuestionLength => quizQuestions.length;

  QuizProvider getQuizOnIndex(int index) => quizQuestions[index];

  void remove(QuizProvider quizProvider) {
    quizQuestions.remove(quizProvider);
    notifyListeners();
  }

  void add(QuizProvider quizProvider) {
    quizQuestions.add(quizProvider);
    notifyListeners();
  }
}
