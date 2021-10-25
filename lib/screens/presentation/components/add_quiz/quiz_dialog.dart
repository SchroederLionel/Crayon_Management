import 'package:crayon_management/datamodels/quiz/response.dart';
import 'package:crayon_management/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuizDialog extends StatefulWidget {
  const QuizDialog({Key? key}) : super(key: key);

  @override
  _QuizDialogState createState() => _QuizDialogState();
}

class _QuizDialogState extends State<QuizDialog> {
  late TextEditingController _questionController;
  late TextEditingController _responseController;
  bool response = false;
  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: '');
    _responseController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    String errorMessage = '';
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
              if (_questionController.text.length >= 4 &&
                  quizProvider.getQuestions.length >= 2) {
                Navigator.pop(context, quizProvider);
              }
            },
            child: Text(translation.upload))
      ],
      content: Builder(
        builder: (context) {
          return Container(
            height: 630,
            width: 500,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  translation.addQuestion,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                            validator: (val) => !isByteLength(val!, 4)
                                ? translation.questionHasToHaveAtLeast4Chars
                                : null,
                            onChanged: (String text) =>
                                quizProvider.setQuestion(text),
                            controller: _questionController,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.book_rounded,
                                  size: 18,
                                ),
                                border: const UnderlineInputBorder(),
                                labelText: translation.response)),
                        Row(
                          children: [
                            Checkbox(
                                value: response,
                                onChanged: (bool? value) {
                                  setState(() {
                                    response = value!;
                                  });
                                }),
                            Flexible(
                              child: TextFormField(
                                  validator: (val) => !isByteLength(val!, 4)
                                      ? translation
                                          .responseHasToHaveAtLeast4Chars
                                      : null,
                                  controller: _responseController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.question_answer_rounded,
                                        size: 18,
                                      ),
                                      border: const UnderlineInputBorder(),
                                      labelText: translation.response)),
                            ),
                            IconButton(
                                onPressed: () {
                                  Response respone = Response(
                                      response: _responseController.text,
                                      isResponseRight: response);
                                  quizProvider.add(respone);
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Consumer<QuizProvider>(
                          builder: (context, quiz, child) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: quizProvider.getQuestions.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .primaryColor))),
                                      child: ListTile(
                                        title: Text(
                                          quizProvider
                                              .getResponse(index)
                                              .getResponse,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        leading: Icon(
                                          Icons.assignment_turned_in_outlined,
                                          color: quizProvider.responseFromIndex(
                                                      index) ==
                                                  true
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            quizProvider.remove(quizProvider
                                                .getResponse(index));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                        const Spacer(),
                        Text(
                          errorMessage,
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 18),
                        )
                      ],
                    ),
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

/**
 * 

 */
