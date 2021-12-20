import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';

class QuizLaunchArguement {
  Lecture lecture;
  List<Quiz> quizes;

  QuizLaunchArguement({required this.lecture, required this.quizes});
}
