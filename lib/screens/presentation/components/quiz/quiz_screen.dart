import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/quiz/quit_participation.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/quiz/lobby_provider.dart';
import 'package:crayon_management/screens/presentation/components/quiz/explain_quiz_dialog.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duration_picker/duration_picker.dart';

class QuizScreen extends StatefulWidget {
  final String lectureId;

  const QuizScreen({required this.lectureId, Key? key}) : super(key: key);

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
      body: StreamProvider<QuizParticipation>(
        create: (context) => QuizService.getQuizParticiants(widget.lectureId),
        initialData: QuizParticipation(participants: [], userResponses: []),
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
                      onPressed: () async {
                        var resultingDuration = await showDurationPicker(
                          context: context,
                          initialTime: const Duration(minutes: 4),
                          baseUnit: BaseUnit.minute,
                        );
                      },
                      child: Text('Set up time for quiz')),
                  const SizedBox(
                    width: 14,
                  ),
                  Consumer<QuizParticipation>(
                      builder: (context, QuizParticipation quizP, child) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: quizP.isLobbyOpen
                                ? MaterialStateProperty.all<Color>(Colors.red)
                                : MaterialStateProperty.all<Color>(
                                    Colors.blueAccent)),
                        onPressed: () {
                          if (quizP.isLobbyOpen) {
                            QuizService.dissalowParticipantsToJoinLobby(
                                widget.lectureId);
                          } else {
                            QuizService.allowParticipantsToJoinLobby(
                                widget.lectureId);
                          }
                        },
                        child: Text('Allow entry to lobby'));
                  }),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ExplainQuizDialog(
                                  currentQuiz: quizSelctor.currentQuiz);
                            });
                      },
                      child: Text('Explain quiz')),
                  ElevatedButton(
                      onPressed: () {
                        QuizService.resetCurrentQuiz(widget.lectureId);
                      },
                      child: Text('Clean up')),
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
                child: Card(
                  child: SizedBox(
                    height: 700,
                    width: 900,
                    child: Consumer2<LobbyProvider, QuizParticipation>(
                      builder: (context, LobbyProvider lobbyprovider,
                          QuizParticipation parti, child) {
                        if (parti.isLobbyOpen) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: parti.participants.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text(parti.participants[index]));
                              });
                        } else {
                          return const Center(
                              child: Text('Lobby is currently closed'));
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
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
