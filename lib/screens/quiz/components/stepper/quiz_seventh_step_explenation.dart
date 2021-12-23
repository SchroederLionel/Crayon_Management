import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizSeventhStepExplenation extends StatefulWidget {
  const QuizSeventhStepExplenation({Key? key}) : super(key: key);

  @override
  State<QuizSeventhStepExplenation> createState() =>
      _QuizSeventhStepExplenationState();
}

class _QuizSeventhStepExplenationState
    extends State<QuizSeventhStepExplenation> {
  PageController _controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final questions = Provider.of<QuizSelectorProvider>(context, listen: false)
        .currentQuiz
        .questions;
    return PageView.builder(
        itemCount: questions.length,
        controller: _controller,
        itemBuilder: (_, index) {
          return Row(
            children: [
              const IconButton(icon: Icon(Icons.arrow_left), onPressed: () {}),
              Text(questions[index].question),
              const Icon(Icons.arrow_right),
            ],
          );
        });
  }
}
