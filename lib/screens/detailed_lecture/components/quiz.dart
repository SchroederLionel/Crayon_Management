import 'package:crayon_management/datamodels/confirmation_dialog/confirmation_dialog_data.dart';
import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/route_arguments/quiz_launch.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/quiz/question_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/providers/quiz/response_provider.dart';
import 'package:crayon_management/providers/util_providers/error_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/add_quiz/quiz_dialog.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:crayon_management/widgets/custom_text.dart';
import 'package:crayon_management/widgets/error_text.dart';
import 'package:crayon_management/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:crayon_management/route/route.dart' as route;

class Quiz extends StatefulWidget {
  final Lecture lecture;
  const Quiz({required this.lecture, Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        Provider.of<QuizProvider>(context, listen: false)
            .getQuizes(widget.lecture.id));
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    var quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              appTranslation!.translate('quiz') ?? 'Quiz',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(width: 14),
            getQuizButton(context),
            const Spacer(),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiProvider(
                          providers: [
                            ChangeNotifierProvider<ResponseProvider>(
                                create: (_) => ResponseProvider()),
                            ChangeNotifierProvider<QuestionProvider>(
                                create: (_) => QuestionProvider()),
                            ChangeNotifierProvider<ErrorProvider>(
                                create: (_) => ErrorProvider())
                          ],
                          child: const QuizDialog(),
                        );
                      }).then((value) {
                    quizProvider.addQuiz(widget.lecture.id, value);
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(
                  appTranslation.translate('addQuestion') ?? 'Add Question',
                ))
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
            height: 300,
            child:
                Consumer<QuizProvider>(builder: (context, quizProvider, child) {
              if (quizProvider.state == NotifierState.initial) {
                return Container();
              } else if (quizProvider.state == NotifierState.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              return quizProvider.quizes.fold(
                  (failure) => ErrorText(error: failure.code),
                  (listQuiz) => ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listQuiz.length,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          listQuiz[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
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
                                                        itemTitle:
                                                            listQuiz[index]
                                                                .title,
                                                      ))).then((value) {
                                                if (value == true) {
                                                  quizProvider.removeQuiz(
                                                      widget.lecture.id,
                                                      listQuiz[index]);
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
                                              listQuiz[index].questions.length,
                                          itemBuilder: (context, index2) {
                                            return Text(
                                              listQuiz[index]
                                                  .questions[index2]
                                                  .question,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ));
            })),
      ],
    );
  }

  Widget getQuizButton(BuildContext context) {
    return Consumer<QuizProvider>(builder: (_, provider, __) {
      if (provider.state == NotifierState.initial) {
        return const SizedBox();
      } else if (provider.state == NotifierState.loaded) {
        return provider.quizes.fold((failure) => const SizedBox(), (quizes) {
          if (quizes.isEmpty) {
            return const SizedBox();
          } else {
            return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(route.quiz,
                      arguments: QuizLaunchArguement(
                          lecture: widget.lecture, quizes: quizes));
                },
                child: const CustomText(
                    safetyText: 'Start quiz', textCode: 'start-quiz'));
          }
        });
      } else if (provider.state == NotifierState.loading) {
        return const LoadingWidget();
      }
      return const SizedBox();
    });
  }
}
