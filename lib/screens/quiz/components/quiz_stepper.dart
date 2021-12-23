import 'package:crayon_management/screens/quiz/components/stepper/quiz_first_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_fith_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_fourth_step_start.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_sixth_step_result.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_thrid_step_lobby.dart';

import 'package:crayon_management/screens/quiz/components/stepper/quiz_second_step_time.dart';
import 'package:flutter/material.dart';

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
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      steps: getSteps(),
      // onStepTapped: (step) => setState(() => _currentStep = step),
      onStepContinue: () {
        final isLastStep = _currentStep == getSteps().length - 1;
        if (isLastStep) {
          print('Completed');
        } else {
          setState(() {
            _currentStep += 1;
          });
        }
      },
      controlsBuilder: (context, {onStepContinue, onStepCancel}) {
        final isLastStep = _currentStep == getSteps().length - 1;
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(child: Text('NEXT'), onPressed: onStepContinue),
          const SizedBox(width: 20),
          if (_currentStep != 0)
            ElevatedButton(child: Text('Back'), onPressed: onStepCancel),
        ]);
      },
      onStepCancel: () {
        _currentStep == 0
            ? null
            : setState(() {
                _currentStep -= 1;
              });
      },
    );
  }

  List<Step> getSteps() => [
        Step(
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text('Select Quiz'),
            isActive: _currentStep >= 1,
            content: QuizFirstStep()),
        Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text('Time'),
            isActive: _currentStep >= 2,
            content: QuizSecondStepTime()),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          title: Text('Lobby'),
          content: QuizThirdStepLobby(),
          isActive: _currentStep >= 3,
        ),
        Step(
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          title: Text('Start quiz'),
          content: QuizFourthStepStart(),
          isActive: _currentStep >= 4,
        ),
        Step(
          state: _currentStep > 4 ? StepState.complete : StepState.indexed,
          title: Text('Timer'),
          content: QuizFithStep(),
          isActive: _currentStep >= 5,
        ),
        Step(
          state: _currentStep > 5 ? StepState.complete : StepState.indexed,
          title: Text('Result'),
          content: QuizSixthStepResult(lectureId: widget.lectureId),
          isActive: _currentStep >= 5,
        ),
      ];
}
