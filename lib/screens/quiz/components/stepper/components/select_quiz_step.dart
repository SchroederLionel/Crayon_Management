import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectQuizStep extends StatelessWidget {
  const SelectQuizStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizSelectorProvider>(
      builder: (_, quizSelector, __) {
        if (quizSelector.quizes.isEmpty) {
          return const CustomText(
            safetyText: 'No quizes are available!',
            textCode: 'no-quizes-are-available',
          );
        } else {
          return SizedBox(
            height: 350,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: quizSelector.quizes.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 350,
                    width: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () =>
                          quizSelector.changeQuiz(quizSelector.quizes[index]),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: quizSelector.currentQuiz ==
                                    quizSelector.quizes[index]
                                ? BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.0,
                                  )
                                : const BorderSide(
                                    width: 0, color: Colors.transparent)),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quizSelector.quizes[index].title,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: quizSelector
                                          .quizes[index].questions.length,
                                      itemBuilder: (context, index2) {
                                        return Text(
                                          quizSelector.quizes[index]
                                              .questions[index2].question,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        );
                                      }),
                                )
                              ],
                            )),
                      ),
                    ),
                  );
                }),
          );
        }
      },
    );
  }
}
