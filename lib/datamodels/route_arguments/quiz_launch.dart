import 'package:crayon_management/datamodels/quiz/quiz.dart';

class QuizLaunchArguement {
  List<Quiz> quizes;
  final String lectureId;

  QuizLaunchArguement({required this.lectureId, required this.quizes});
}
