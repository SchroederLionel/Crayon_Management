import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/quiz/quiz.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:crayon_management/widgets/snackbar.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepperProvider extends ChangeNotifier {
  BuildContext context;
  String lectureId;
  StepperProvider({required this.context, required this.lectureId});

  StepperState _state = StepperState.select;
  int _currentPage = 0;
  int get currentPage => _currentPage;
  StepperState get state => _state;

  setState(StepperState state) {
    _state = state;
    setCurrentPage(state);
    notifyListeners();
  }

  setCurrentPage(StepperState state) {
    if (state == StepperState.select) {
      _currentPage = 0;
    } else if (state == StepperState.time) {
      _currentPage = 1;
    } else if (state == StepperState.lobby) {
      _currentPage = 2;
    } else if (state == StepperState.countdown) {
      _currentPage = 3;
    } else if (state == StepperState.result) {
      _currentPage = 4;
    } else if (state == StepperState.explenation) {
      _currentPage = 5;
    }
  }

  Widget getButtons(BuildContext context) {
    if (_state == StepperState.select) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Quiz choosen'),
              onPressed: () => setState(StepperState.time)),
        ],
      );
    } else if (_state == StepperState.time) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Time Picked (You wont be able to go back)'),
              onPressed: () async {
                Either<Failure, void> quizes = await Task(() =>
                        QuizService.allowParticipantsToJoinLobby(lectureId))
                    .attempt()
                    .map(
                      (either) => either.leftMap((obj) {
                        try {
                          return obj as Failure;
                        } catch (e) {
                          throw obj;
                        }
                      }),
                    )
                    .run();
                quizes.fold((failure) {
                  CustomSnackbar(
                      text: 'Could not close the lobby', color: Colors.red);
                  setState(StepperState.lobby);
                }, (success) => setState(StepperState.lobby));
              }),
          const SizedBox(width: 20),
          ElevatedButton(
              child: Text('Back'),
              onPressed: () => setState(StepperState.select))
        ],
      );
    } else if (_state == StepperState.lobby) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Start quiz'),
              onPressed: () async {
                Either<Failure, void> quizes = await Task(() =>
                        QuizService.closeLobbyAndStartQuiz(
                            lectureId,
                            Provider.of<QuizSelectorProvider>(context,
                                    listen: false)
                                .currentQuiz))
                    .attempt()
                    .map(
                      (either) => either.leftMap((obj) {
                        try {
                          return obj as Failure;
                        } catch (e) {
                          throw obj;
                        }
                      }),
                    )
                    .run();
                quizes.fold((failure) {
                  CustomSnackbar(
                      text: 'Could not close the lobby', color: Colors.red);
                  setState(StepperState.countdown);
                }, (success) => setState(StepperState.countdown));
              }),
        ],
      );
    } else if (_state == StepperState.countdown) {
      return const SizedBox();
    } else if (_state == StepperState.result) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Explain quiz'),
              onPressed: () => setState(StepperState.explenation)),
        ],
      );
    } else if (_state == StepperState.explenation) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Finished'),
              onPressed: () async {
                Either<Failure, void> quizes =
                    await Task(() => QuizService.cleanQuiz(
                              lectureId,
                            ))
                        .attempt()
                        .map(
                          (either) => either.leftMap((obj) {
                            try {
                              return obj as Failure;
                            } catch (e) {
                              throw obj;
                            }
                          }),
                        )
                        .run();
                quizes.fold((failure) {
                  CustomSnackbar(
                      text: 'Could not close the lobby', color: Colors.red);
                  setState(StepperState.countdown);
                }, (success) => Navigator.of(context).pop());

                ;
              }),
        ],
      );
    }
    return Container();
  }
}
