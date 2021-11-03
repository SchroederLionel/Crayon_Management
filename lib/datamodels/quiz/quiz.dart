import 'package:crayon_management/datamodels/quiz/question.dart';

class Quiz {
  late String id;
  String title;
  List<Question> questions;

  Quiz({required this.title, required this.questions});

  setId(String id) => this.id = id;

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final title = json['title'] as String;
    final questionData = json['questions'] as List<dynamic>?;
    final questions = questionData != null
        ? questionData.map((questions) => Question.fromJson(questions)).toList()
        : <Question>[];
    Quiz quiz = Quiz(title: title, questions: questions);
    quiz.setId(id);
    return quiz;
  }

  Map<String, dynamic> toJson() => {'id': id, 'questions': questions};
}
