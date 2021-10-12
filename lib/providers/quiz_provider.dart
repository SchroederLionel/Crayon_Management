import 'package:flutter/cupertino.dart';

class QuizProvider extends ChangeNotifier {
  String _question = '';
  List<Response> _questions = [];
  void setQuestion(String question) => _question = question;

  String get getQuestion => _question;
  Response getResponse(int index) => _questions[index];
  List<Response> get getQuestions => _questions;

  void add(Response question) {
    _questions.add(question);
    notifyListeners();
  }

  bool responseFromIndex(int index) => getResponse(index).isQuestionRight;
  void remove(Response question) {
    _questions.remove(question);
    notifyListeners();
  }
}

class Response {
  late String question;
  late bool isQuestionRight;
  Response({required this.question, required this.isQuestionRight});

  String get getQuestion => question;
  bool get getQuestionRight => isQuestionRight;
}
