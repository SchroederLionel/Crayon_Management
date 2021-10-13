import 'package:flutter/cupertino.dart';

class QuizProvider extends ChangeNotifier {
  String _question = '';
  final List<Response> _responses = [];
  void setQuestion(String question) => _question = question;

  String get getQuestion => _question;
  Response getResponse(int index) => _responses[index];
  List<Response> get getQuestions => _responses;

  void add(Response question) {
    _responses.add(question);
    notifyListeners();
  }

  bool responseFromIndex(int index) => getResponse(index).isResponseRight;
  void remove(Response question) {
    _responses.remove(question);
    notifyListeners();
  }
}

class Response {
  late String response;
  late bool isResponseRight;
  Response({required this.response, required this.isResponseRight});

  String get getResponse => response;
  bool get getResponseRight => isResponseRight;
}
