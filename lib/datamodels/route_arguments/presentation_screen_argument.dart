import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';

class PresentationScreenArgument {
  List<Quiz> quizes;
  Lecture lecture;
  final String fileId;
  PresentationScreenArgument(
      {required this.lecture, required this.fileId, required this.quizes});
}
