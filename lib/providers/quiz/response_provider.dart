import 'package:crayon_management/datamodels/quiz/response.dart';
import 'package:flutter/cupertino.dart';

class ResponseProvider extends ChangeNotifier {
  String _question = '';
  List<Response> _responses = [];
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

  void clearResponses() {
    _question = '';
    _responses = <Response>[];
    notifyListeners();
  }

  void setUp(String quesiton, List<Response> responses) {
    _question = quesiton;
    _responses = responses;
    notifyListeners();
  }
}