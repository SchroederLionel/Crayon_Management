import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/quiz/user_responses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplenationStep extends StatefulWidget {
  const ExplenationStep({Key? key}) : super(key: key);

  @override
  State<ExplenationStep> createState() => _ExplenationStepState();
}

class _ExplenationStepState extends State<ExplenationStep> {
  final PageController _controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final userResponsesProvider =
        Provider.of<UserResponsesProvider>(context, listen: false);
    final questions = Provider.of<QuizSelectorProvider>(context, listen: false)
        .currentQuiz
        .questions;
    return SizedBox(
      height: 500,
      child: PageView.builder(
          itemCount: questions.length,
          controller: _controller,
          itemBuilder: (_, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          if (currentPage != 0) {
                            setState(() {
                              currentPage--;
                              _controller.jumpToPage(currentPage);
                            });
                          }
                        }),
                    Text(
                      questions[index].question,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 48),
                    ),
                    IconButton(
                        onPressed: () {
                          if (currentPage < questions.length - 1) {
                            setState(() {
                              currentPage++;
                              _controller.jumpToPage(currentPage);
                            });
                          }
                        },
                        icon: const Icon(Icons.arrow_right)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userResponsesProvider.getHowManyGotQuestionRightAndWrong(
                              questions[index].question)!["right"] ??
                          '',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 48),
                    ),
                    Text(
                      userResponsesProvider.getHowManyGotQuestionRightAndWrong(
                              questions[index].question)!["wrong"] ??
                          '',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 48),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
