import 'package:crayon_management/datamodels/quiz/quiz.dart';

class Quizes {
  String id;
  List<Quiz> quizes;
  Quizes({required this.id, required this.quizes});

  factory Quizes.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final quizesData = json['quizes'] as List<dynamic>?;
    final quizes = quizesData != null
        ? quizesData.map((quiz) => Quiz.fromJson(quiz)).toList()
        : <Quiz>[];

    return Quizes(id: id, quizes: quizes);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'quizes': quizes.map((quiz) => quiz.toJson()).toList()};
}
