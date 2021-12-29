import 'package:crayon_management/providers/quiz/stepper_provider.dart';
import 'package:crayon_management/screens/quiz/components/stepper/components/select_quiz_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/components/count_down_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/components/select_time_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/components/explenation_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/components/result_step.dart';
import 'package:crayon_management/screens/quiz/components/stepper/components/lobby_step.dart';
import 'package:crayon_management/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizStepper extends StatefulWidget {
  final String lectureId;
  const QuizStepper({Key? key, required this.lectureId}) : super(key: key);

  @override
  State<QuizStepper> createState() => _QuizStepperState();
}

class _QuizStepperState extends State<QuizStepper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StepperProvider>(builder: (_, provider, __) {
      return Stepper(
        type: StepperType.horizontal,
        currentStep: provider.currentPage,
        steps: getSteps(provider),
        controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
            provider.getButtons(context),
      );
    });
  }

  List<Step> getSteps(StepperProvider provider) => [
        Step(
            state: provider.currentPage > 0
                ? StepState.complete
                : StepState.indexed,
            title: const CustomText(
                safetyText: 'Select Quiz', textCode: 'select-quiz'),
            isActive: provider.currentPage >= 1,
            content: const SelectQuizStep()),
        Step(
            state: provider.currentPage > 1
                ? StepState.complete
                : StepState.indexed,
            title: const CustomText(safetyText: 'Time', textCode: 'time'),
            isActive: provider.currentPage >= 2,
            content: const SelectTimeStep()),
        Step(
          state:
              provider.currentPage > 2 ? StepState.complete : StepState.indexed,
          title: const CustomText(safetyText: 'Lobby', textCode: 'lobby'),
          content: LobbyStep(lectureId: widget.lectureId),
          isActive: provider.currentPage >= 3,
        ),
        Step(
          state:
              provider.currentPage > 3 ? StepState.complete : StepState.indexed,
          title: const CustomText(safetyText: 'Timer', textCode: 'timer'),
          content: const CountDownStep(),
          isActive: provider.currentPage >= 4,
        ),
        Step(
          state:
              provider.currentPage > 4 ? StepState.complete : StepState.indexed,
          title: const CustomText(safetyText: 'Result', textCode: 'result'),
          content: ResultStep(lectureId: widget.lectureId),
          isActive: provider.currentPage >= 5,
        ),
        Step(
          state:
              provider.currentPage > 5 ? StepState.complete : StepState.indexed,
          title: const CustomText(
              safetyText: 'Explentation', textCode: 'explentation'),
          content: const ExplenationStep(),
          isActive: provider.currentPage >= 6,
        ),
      ];
}
