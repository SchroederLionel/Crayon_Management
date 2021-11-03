import 'package:crayon_management/datamodels/quiz/question.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/datamodels/quiz/response.dart';
import 'package:crayon_management/providers/quiz/question_provider.dart';

import 'package:crayon_management/providers/quiz/response_provider.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuizDialog extends StatefulWidget {
  const QuizDialog({Key? key}) : super(key: key);

  @override
  _QuizDialogState createState() => _QuizDialogState();
}

class _QuizDialogState extends State<QuizDialog> {
  late TextEditingController _quizTitleController;
  late TextEditingController _questionController;
  late TextEditingController _responseController;
  String errorMessage = '';
  bool response = false;
  @override
  void initState() {
    super.initState();
    _quizTitleController = TextEditingController(text: '');
    _questionController = TextEditingController(text: '');
    _responseController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _quizTitleController.dispose();
    _questionController.dispose();
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final responseProvider =
        Provider.of<ResponseProvider>(context, listen: false);
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    return AlertDialog(
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black26)),
            onPressed: () => Navigator.pop(context, null),
            child: Text(translation!.cancel)),
        ElevatedButton(
            onPressed: () {
              if (_quizTitleController.text.length >= 4 &&
                  responseProvider.getQuestions.length >= 2) {
                Quiz quiz = Quiz(
                    title: _quizTitleController.text,
                    questions: questionProvider.questions);
                Navigator.pop(context, quiz);
              }
            },
            child: Text(translation.upload))
      ],
      content: Builder(
        builder: (context) {
          return Container(
            height: 730,
            width: 500,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  translation.quiz,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomTextFormField(
                    validator: (String? text) =>
                        ValidatorService.isStringLengthAbove2(text, context),
                    onChanged: (String value) {},
                    controller: _quizTitleController,
                    icon: Icons.title,
                    labelText: 'Quiz Title',
                    isPassword: false),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  translation.addQuestion,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                          validator: (String? text) =>
                              ValidatorService.isStringLengthAbove2(
                                  text, context),
                          onChanged: (String value) {},
                          controller: _questionController,
                          icon: Icons.question_answer,
                          labelText: 'Question',
                          isPassword: false),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    IconButton(
                        onPressed: () {
                          Question question = Question(
                              question: _questionController.text,
                              responses: responseProvider.getQuestions);

                          questionProvider.addQuestion(question);
                          responseProvider.clearResponses();
                          _questionController.text = '';
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        width: 400,
                        height: 70,
                        child: Row(
                          children: [
                            Checkbox(
                                value: response,
                                onChanged: (bool? value) {
                                  setState(() {
                                    response = value!;
                                  });
                                }),
                            Expanded(
                                child: CustomTextFormField(
                                    validator: (text) =>
                                        ValidatorService.isStringLengthAbove2(
                                            text, context),
                                    onChanged: (String text) {},
                                    controller: _responseController,
                                    icon: Icons.question_answer_rounded,
                                    labelText: translation.response,
                                    isPassword: false)),
                            IconButton(
                                onPressed: () {
                                  Response respone = Response(
                                      response: _responseController.text,
                                      isResponseRight: response);
                                  _responseController.text = '';
                                  responseProvider.add(respone);
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        width: 335,
                        height: 200,
                        child: Consumer<ResponseProvider>(
                          builder: (context, responseProvider, child) {
                            return ListView.builder(
                                itemCount: responseProvider.getQuestions.length,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                        leading: Icon(
                                          Icons.assignment_turned_in_outlined,
                                          color: responseProvider
                                                      .responseFromIndex(
                                                          index) ==
                                                  true
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            responseProvider.remove(
                                                responseProvider
                                                    .getResponse(index));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        title: Text(
                                          responseProvider
                                              .getResponse(index)
                                              .getResponse,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        )),
                                  );
                                });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Expanded(child: Consumer<QuestionProvider>(
                        builder: (context, questionProvider, child) {
                          return ListView.builder(
                              itemCount: questionProvider.questions.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _questionController.text = questionProvider
                                        .questions[index].question;

                                    responseProvider.setUp(
                                        questionProvider
                                            .questions[index].question,
                                        questionProvider
                                            .questions[index].responses);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(questionProvider
                                          .questions[index].question),
                                      trailing: IconButton(
                                        onPressed: () {
                                          questionProvider.removeQuestion(
                                              questionProvider
                                                  .questions[index]);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      )),
                      Text(
                        errorMessage,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
