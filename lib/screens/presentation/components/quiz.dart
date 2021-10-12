import 'package:crayon_management/datamodels/confirmation_dialog_data.dart';
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
                          child: QuizDialog(),
                        );
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
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                height: 350,
                width: 300,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question 1',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext
                                            context) =>
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
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Text('S');
                            }),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
