import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/quiz/quit_participation.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/quiz/lobby_provider.dart';
import 'package:crayon_management/screens/quiz/explain_quiz_dialog.dart';
import 'package:crayon_management/screens/quiz/quiz_lobby.dart';
import 'package:crayon_management/screens/quiz/quiz_options_row.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duration_picker/duration_picker.dart';

class QuizScreen extends StatefulWidget {
  final Lecture lecture;

  const QuizScreen({required this.lecture, Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Duration _duration;
  @override
  void initState() {
    super.initState();
    _duration = const Duration(hours: 0, minutes: 4);
  }

  @override
  Widget build(BuildContext context) {
    final quizSelctor =
        Provider.of<QuizSelectorProvider>(context, listen: false);
    return Scaffold(
      body: StreamProvider<List<String>>(
        create: (context) => QuizService.getQuizParticiants(widget.lecture.id),
        initialData: const [],
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Quiz',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Spacer(),
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
              QuizOptionsRow(lecture: widget.lecture),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Lobby',
                style: Theme.of(context).textTheme.headline2,
              ),
              const QuizLobby(),
              const SizedBox(
                height: 14,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    QuizService.startQuiz(
                        widget.lecture.id, quizSelctor.currentQuiz);
                  },
                  child: Text('Start Quiz'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
