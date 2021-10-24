import 'package:crayon_management/datamodels/quiz/question.dart';

class Quiz {
  String id;
  List<Question> questions;

  Quiz({required this.id, required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final questionData = json['questions'] as List<dynamic>?;
    final questions = questionData != null
        ? questionData.map((questions) => Question.fromJson(questions)).toList()
        : <Question>[];
    return Quiz(id: id, questions: questions);
  }

  Map<String, dynamic> toJson() => {'id': id, 'questions': questions};
}
