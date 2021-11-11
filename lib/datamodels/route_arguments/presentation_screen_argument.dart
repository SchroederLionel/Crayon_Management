import 'package:crayon_management/datamodels/quiz/quiz.dart';

class PresentationScreenArgument {
  List<Quiz> quizes;
  final String lectureId;
  final String fileId;
  PresentationScreenArgument(
      {required this.lectureId, required this.fileId, required this.quizes});
}
