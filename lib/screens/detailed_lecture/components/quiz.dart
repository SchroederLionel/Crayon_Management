import 'package:crayon_management/datamodels/confirmation_dialog/confirmation_dialog_data.dart';
import 'package:crayon_management/providers/quiz/question_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';

import 'package:crayon_management/providers/quiz/response_provider.dart';
import 'package:crayon_management/providers/util_providers/menu_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/add_quiz/quiz_dialog.dart';

import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translation!.quiz,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiProvider(
                          providers: [
                            ChangeNotifierProvider<ResponseProvider>(
                                create: (context) => ResponseProvider()),
                            ChangeNotifierProvider<QuestionProvider>(
                                create: (context) => QuestionProvider())
                          ],
                          child: const QuizDialog(),
                        );
                      }).then((value) {
                    if (value != null) {
                      quizProvider.addQuiz(value);
                    }
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(
                  translation.addQuestion,
                ))
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
            height: 300,
            child: Consumer<QuizProvider>(builder: (context, questions, child) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: questions.lengthOfQuizes(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 350,
                    width: 300,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  questions.getQuiz(index).title,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              ConfirmationDialog(
                                                  confirmationDialogData:
                                                      ConfirmationDialogData(
                                                          title: translation
                                                              .delete,
                                                          cancelTitle:
                                                              translation
                                                                  .cancel,
                                                          itemTitle: questions
                                                              .getQuiz(index)
                                                              .title,
                                                          description: translation
                                                              .confirmationDeletion,
                                                          acceptTitle:
                                                              translation
                                                                  .yes))).then(
                                          (value) {
                                        if (value == true) {
                                          questions.removeQuiz(
                                              questions.getQuiz(index));
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      questions.getQuiz(index).questions.length,
                                  itemBuilder: (context, index2) {
                                    return Text(
                                      questions
                                          .getQuiz(index)
                                          .questions[index2]
                                          .question,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            })),
      ],
    );
  }
}
