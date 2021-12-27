import 'package:crayon_management/datamodels/quiz/question.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  int? _seconds;
  setSeconds(int seconds) => _seconds = seconds;
  String id = const Uuid().v4();
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'seconds': _seconds ?? 100,
        'title': title,
        'questions': questions.map((question) => question.toJson()).toList()
      };
}
