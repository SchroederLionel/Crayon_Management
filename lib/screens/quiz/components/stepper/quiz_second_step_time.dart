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
  Duration? time;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          time == null
              ? const SizedBox()
              : DurationPicker(
                  onChange: (Duration value) => setState(() {
                    time = value;
                    Provider.of<QuizSelectorProvider>(context, listen: false)
                        .setSeconds(time!.inSeconds);
                  }),
                  baseUnit: BaseUnit.second,
                  duration: time!,
                ),
          const SizedBox(height: 20),
          time == null ? const SizedBox() : Text('${time!.inSeconds}/s'),
          const SizedBox(height: 20),
        ]);
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        time = Duration(
            seconds: Provider.of<QuizSelectorProvider>(context, listen: false)
                .seconds);
      });
    });
    super.initState();
  }
}
