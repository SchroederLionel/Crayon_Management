import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/quiz/quit_participation.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/screens/quiz/explain_quiz_dialog.dart';
import 'package:crayon_management/screens/quiz/quiz_lobby_button.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizOptionsRow extends StatelessWidget {
  final Lecture lecture;
  const QuizOptionsRow({Key? key, required this.lecture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizSelctor =
        Provider.of<QuizSelectorProvider>(context, listen: false);
    return Row(
      children: [
        Consumer<QuizSelectorProvider>(
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
                  items: quizSelector.quizes
                      .map<DropdownMenuItem<Quiz>>((Quiz quiz) {
                    return DropdownMenuItem<Quiz>(
                      value: quiz,
                      child: Text(quiz.title),
                    );
                  }).toList());
            }
          },
        ),
        const SizedBox(
          width: 14,
        ),
        ElevatedButton(
            onPressed: () async {
              var resultingDuration = await showDurationPicker(
                context: context,
                initialTime: const Duration(minutes: 4),
                baseUnit: BaseUnit.minute,
              );
            },
            child: Text('Set up time for quiz')),
        const SizedBox(
          width: 14,
        ),
        QuizLobbyButton(lecture: lecture),
        const Spacer(),
        ElevatedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ExplainQuizDialog(
                        currentQuiz: quizSelctor.currentQuiz);
                  });
            },
            child: Text('Explain quiz')),
        ElevatedButton(
            onPressed: () {
              QuizService.resetCurrentQuiz(lecture.id);
            },
            child: Text('Clean up')),
      ],
    );
  }
}
