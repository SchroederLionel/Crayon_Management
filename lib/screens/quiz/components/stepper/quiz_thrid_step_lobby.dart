import 'package:crayon_management/screens/quiz/quiz_lobby.dart';
import 'package:flutter/cupertino.dart';

class QuizThirdStepLobby extends StatelessWidget {
  const QuizThirdStepLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: const QuizLobby()));
  }
}
