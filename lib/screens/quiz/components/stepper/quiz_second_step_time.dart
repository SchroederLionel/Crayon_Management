import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class QuizSecondStepTime extends StatelessWidget {
  const QuizSecondStepTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          var resultingDuration = await showDurationPicker(
            context: context,
            initialTime: const Duration(seconds: 100),
            baseUnit: BaseUnit.minute,
          );
        },
        child: Text('Set up time for quiz'));
  }
}
