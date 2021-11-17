import 'package:crayon_management/datamodels/quiz/quit_participation.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final String lectureId;

  const QuizScreen({required this.lectureId, Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<QuizParticipation>(
        create: (context) => QuizService.getQuizParticiants(widget.lectureId),
        initialData: QuizParticipation(participants: [], userResponses: []),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Quiz',
                  style: Theme.of(context).textTheme.headline1,
                ),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 18,
                    ))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Setup',
              style: Theme.of(context).textTheme.headline2,
            ),
            Row(
              children: [
                Consumer<QuizSelectorProvider>(
                  builder: (_, quizSelector, __) {
                    if (quizSelector.quizes.isEmpty) {
                      return Container(
                        width: 100,
                      );
                    } else {
                      return DropdownButton<Quiz>(
                          value: quizSelector.currentQuiz,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 14,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white24),
                          underline: Container(
                            height: 0,
                          ),
                          onChanged: (Quiz? quiz) {
                            if (quiz != null) {
                              quizSelector.changeQuiz(quiz);
                            }
                          },
                          items: quizSelector.quizes
                              .map<DropdownMenuItem<Quiz>>((Quiz quiz) {
                            return DropdownMenuItem<Quiz>(
                              value: quiz,
                              child: Text(quiz.title),
                            );
                          }).toList());
                    }
                  },
                ),
                const SizedBox(
                  width: 14,
                ),
                ElevatedButton(
                    onPressed: () {}, child: Text('Set up time for quiz'))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Lobby',
              style: Theme.of(context).textTheme.headline2,
            ),
            Center(
              child: Container(
                height: 500,
                width: 900,
                child: Consumer<QuizParticipation>(
                  builder: (context, QuizParticipation parti, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: parti.participants.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(parti.participants[index]));
                        });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
