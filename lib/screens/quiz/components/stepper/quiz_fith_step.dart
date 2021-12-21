import 'dart:async';

import 'package:crayon_management/providers/presentation/quiz_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFithStep extends StatefulWidget {
  const QuizFithStep({Key? key}) : super(key: key);

  @override
  State<QuizFithStep> createState() => _QuizFithStepState();
}

class _QuizFithStepState extends State<QuizFithStep> {
  late Timer _timer;
  int? _start;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _start = Provider.of<QuizSelectorProvider>(context).seconds;
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
    return Text("$_start");
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
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
