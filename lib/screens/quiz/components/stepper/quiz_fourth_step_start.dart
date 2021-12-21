import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFourthStepStart extends StatelessWidget {
  const QuizFourthStepStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizSelctor =
        Provider.of<QuizSelectorProvider>(context, listen: false);
    return Center(
      child: ElevatedButton(
        onPressed: () {
          QuizService.startQuiz(quizSelctor.lectureId, quizSelctor.currentQuiz);
        },
        child: Text('Start Quiz'),
      ),
    );
  }
}
