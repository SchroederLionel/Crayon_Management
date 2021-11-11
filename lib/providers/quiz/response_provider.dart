import 'package:crayon_management/datamodels/quiz/response.dart';
import 'package:flutter/cupertino.dart';

class ResponseProvider extends ChangeNotifier {
  List<Response> _responses = [];

  Response getResponse(int index) => _responses[index];
  List<Response> get getResponses => _responses;

  void add(Response question) {
    _responses.add(question);
    notifyListeners();
  }

  bool responseFromIndex(int index) => getResponse(index).isResponseRight;
  void remove(Response question) {
    _responses.remove(question);
    notifyListeners();
  }

  void setUp(String quesiton, List<Response> responses) {
    _responses = responses;
    notifyListeners();
  }

  void clearResponses() {
    _responses = [];
    notifyListeners();
  }
}
