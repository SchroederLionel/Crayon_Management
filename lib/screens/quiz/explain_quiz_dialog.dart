import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:flutter/material.dart';

class ExplainQuizDialog extends StatelessWidget {
  final Quiz currentQuiz;
  const ExplainQuizDialog({required this.currentQuiz, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: ListView.builder(
            itemCount: currentQuiz.questions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(currentQuiz.questions[index].question),
              );
            }),
      ),
    );
  }
}
