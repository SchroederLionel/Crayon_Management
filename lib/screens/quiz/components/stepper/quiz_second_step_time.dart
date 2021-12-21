import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizSecondStepTime extends StatefulWidget {
  const QuizSecondStepTime({Key? key}) : super(key: key);

  @override
  State<QuizSecondStepTime> createState() => _QuizSecondStepTimeState();
}

class _QuizSecondStepTimeState extends State<QuizSecondStepTime> {
  Duration result = const Duration(seconds: 100);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DurationPicker(
            onChange: (Duration value) => setState(() {
              result = value;
              Provider.of<QuizSelectorProvider>(context)
                  .setSeconds(result.inMilliseconds);
            }),
            baseUnit: BaseUnit.second,
            duration: result,
          ),
          const SizedBox(height: 20),
          Text('${result.inSeconds}/s'),
          const SizedBox(height: 20),
        ]);
  }
}
