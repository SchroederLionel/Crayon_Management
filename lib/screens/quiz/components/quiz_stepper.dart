import 'package:crayon_management/providers/quiz/stepper_provider.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_first_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_fith_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_fourth_step_start.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_seventh_step_explenation.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_sixth_step_result.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_thrid_step_lobby.dart';

import 'package:crayon_management/screens/quiz/components/stepper/quiz_second_step_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizStepper extends StatefulWidget {
  final String lectureId;
  const QuizStepper({Key? key, required this.lectureId}) : super(key: key);

  @override
  State<QuizStepper> createState() => _QuizStepperState();
}

class _QuizStepperState extends State<QuizStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<StepperProvider>(builder: (_, provider, __) {
      return Stepper(
        type: StepperType.horizontal,
        currentStep: provider.currentPage,
        steps: getSteps(provider),
        controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
            provider.getButtons(),
      );
    });
  }

  List<Step> getSteps(StepperProvider provider) => [
        Step(
            state: provider.currentPage > 0
                ? StepState.complete
                : StepState.indexed,
            title: Text('Select Quiz'),
            isActive: provider.currentPage >= 1,
            content: QuizFirstStep()),
        Step(
            state: provider.currentPage > 1
                ? StepState.complete
                : StepState.indexed,
            title: Text('Time'),
            isActive: provider.currentPage >= 2,
            content: QuizSecondStepTime()),
        Step(
          state:
              provider.currentPage > 2 ? StepState.complete : StepState.indexed,
          title: Text('Lobby'),
          content: QuizThirdStepLobby(),
          isActive: _currentStep >= 3,
        ),
        Step(
          state:
              provider.currentPage > 3 ? StepState.complete : StepState.indexed,
          title: Text('Timer'),
          content: QuizFithStep(),
          isActive: provider.currentPage >= 4,
        ),
        Step(
          state:
              provider.currentPage > 4 ? StepState.complete : StepState.indexed,
          title: Text('Result'),
          content: QuizSixthStepResult(lectureId: widget.lectureId),
          isActive: _currentStep >= 5,
        ),
        Step(
          state:
              provider.currentPage > 5 ? StepState.complete : StepState.indexed,
          title: Text('Explenation'),
          content: const QuizSeventhStepExplenation(),
          isActive: provider.currentPage >= 6,
        ),
      ];
}
