import 'dart:async';

import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:crayon_management/providers/quiz/stepper_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountDownStep extends StatefulWidget {
  const CountDownStep({Key? key}) : super(key: key);

  @override
  State<CountDownStep> createState() => _CountDownStepState();
}

class _CountDownStepState extends State<CountDownStep> {
  late Timer _timer;
  int? _start;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _start =
            Provider.of<QuizSelectorProvider>(context, listen: false).seconds +
                2;

        startTimer();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_start == null) {
      return const SizedBox();
    }
    return Column(
      children: [
        Center(
          child: Text(
            '$_start',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 160, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _timer.cancel();
              Provider.of<StepperProvider>(context, listen: false)
                  .setState(StepperState.result);
            },
            child: Text('Finish quiz early'))
      ],
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Provider.of<StepperProvider>(context, listen: false)
                .setState(StepperState.result);
          });
        } else {
          setState(() {
            _start = _start! - 1;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
