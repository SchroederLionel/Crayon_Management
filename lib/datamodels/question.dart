import 'package:crayon_management/datamodels/response.dart';

class Question {
  String question;
  List<Response> responses;
  Question({required this.question, required this.responses});
}
