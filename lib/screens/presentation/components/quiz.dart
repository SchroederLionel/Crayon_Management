import 'package:crayon_management/datamodels/confirmation_dialog_data.dart';
import 'package:crayon_management/providers/quiz_list_provider.dart';
import 'package:crayon_management/providers/quiz_provider.dart';
import 'package:crayon_management/screens/presentation/components/quiz_dialog.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizListProvider =
        Provider.of<QuizListProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quiz',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ListenableProvider<QuizProvider>(
                          create: (context) => QuizProvider(),
                          child: const QuizDialog(),
                        );
                      }).then((value) {
                    if (value != null) {
                      quizListProvider.add(value);
                    }
                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add question'))
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
            height: 300,
            child: Consumer<QuizListProvider>(
                builder: (context, questions, child) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: questions.getQuestionLength,
                itemBuilder: (context, index) {
                  return Container(
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
                                  questions.getQuizOnIndex(index).getQuestion,
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
                                                          title: 'Deletion',
                                                          cancelTitle: 'Cancel',
                                                          description:
                                                              'Are you sure you want to delete _________.',
                                                          acceptTitle: 'Yes')));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: questions
                                      .getQuizOnIndex(index)
                                      .getQuestions
                                      .length,
                                  itemBuilder: (context, index2) {
                                    return Text(
                                      questions
                                          .getQuizOnIndex(index)
                                          .getQuestions[index2]
                                          .getResponse,
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
