import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/quiz/quit_participation.dart';
import 'package:crayon_management/datamodels/quiz/quiz_result_user.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/providers/quiz/user_responses_provider.dart';
import 'package:crayon_management/widgets/error_text.dart';
import 'package:crayon_management/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizSixthStepResult extends StatefulWidget {
  final String lectureId;
  const QuizSixthStepResult({Key? key, required this.lectureId})
      : super(key: key);

  @override
  _QuizSixthStepResultState createState() => _QuizSixthStepResultState();
}

class _QuizSixthStepResultState extends State<QuizSixthStepResult> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<UserResponsesProvider>(context, listen: false)
          .getUserResponses(widget.lectureId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuizProvider =
        Provider.of<QuizSelectorProvider>(context, listen: false);
    return Consumer<UserResponsesProvider>(builder: (_, provider, __) {
      if (provider.state == NotifierState.initial) {
        return const SizedBox();
      } else if (provider.state == NotifierState.loading) {
        return const LoadingWidget();
      } else {
        return provider.quizResponses!
            .fold((failure) => ErrorText(error: failure.code),
                (List<QuizResultUser> responses) {
          responses.sort((b, a) => a.score.compareTo(b.score));

          return Column(
            children: [
              Text('Only the best',
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 30),
              Text(
                  '${provider.getMaxScore(currentQuizProvider.currentQuiz, currentQuizProvider.seconds)}'),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: responses.length > 5 ? 5 : responses.length,
                      itemBuilder: (_, index) {
                        return Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                responses[index].userName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                '${responses[index].score}',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline2,
                              )
                            ]);
                      }),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          );
        });
      }
    });
  }
}
