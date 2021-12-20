import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFirstStep extends StatelessWidget {
  const QuizFirstStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizSelectorProvider>(
      builder: (_, quizSelector, __) {
        if (quizSelector.quizes.isEmpty) {
          return Container(
            width: 100,
          );
        } else {
          return DropdownButton<Quiz>(
              value: quizSelector.currentQuiz,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 14,
              style: const TextStyle(fontSize: 14, color: Colors.white24),
              underline: Container(
                height: 0,
              ),
              onChanged: (Quiz? quiz) {
                if (quiz != null) {
                  quizSelector.changeQuiz(quiz);
                }
              },
              items:
                  quizSelector.quizes.map<DropdownMenuItem<Quiz>>((Quiz quiz) {
                return DropdownMenuItem<Quiz>(
                  value: quiz,
                  child: Text(quiz.title),
                );
              }).toList());
        }
      },
    );
  }
}
