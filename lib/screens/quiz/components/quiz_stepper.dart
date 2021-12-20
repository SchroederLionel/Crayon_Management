import 'package:crayon_management/screens/quiz/components/stepper/quiz_first_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_thrid_step_lobby.dart';

import 'package:crayon_management/screens/quiz/components/stepper/quiz_second_step_time.dart';
import 'package:flutter/material.dart';

class QuizStepper extends StatefulWidget {
  const QuizStepper({Key? key}) : super(key: key);

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
      onStepContinue: () {
        setState(() {
          _currentStep += 1;
        });
      },
      onStepCancel: () {
        setState(() {
          _currentStep -= 1;
        });
      },
    );
  }

  List<Step> getSteps() => [
        Step(
            title: Text('Select the quiz you want to start'),
            isActive: _currentStep >= 1,
            content: QuizFirstStep()),
        Step(
            title: Text('How mutch time should the quiz take.'),
            isActive: _currentStep >= 2,
            content: QuizSecondStepTime()),
        Step(
          title: Text('Player lobby'),
          content: QuizThirdStepLobby(),
          isActive: _currentStep >= 3,
        ),
      ];
}
