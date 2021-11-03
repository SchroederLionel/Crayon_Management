import 'package:crayon_management/datamodels/quiz/question.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> questions = <Question>[];

  addQuestion(Question question) {
    questions.add(question);
    notifyListeners();
  }

  removeQuestion(Question question) {
    questions.remove(question);
    notifyListeners();
  }
}
