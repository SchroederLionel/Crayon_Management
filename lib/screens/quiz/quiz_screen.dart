import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/screens/quiz/components/stepper/quiz_stepper.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:crayon_management/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final Lecture lecture;

  const QuizScreen({required this.lecture, Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                    safetyText: 'Quiz',
                    textCode: 'quiz',
                    style: Theme.of(context).textTheme.headline1),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 18,
                    ))
              ],
            ),
            Expanded(child: QuizStepper(lectureId: widget.lecture.id))
          ],
        ),
      ),
    );
  }
}
