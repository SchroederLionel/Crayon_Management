import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:flutter/material.dart';

class QuizLobbyButton extends StatefulWidget {
  final Lecture lecture;
  const QuizLobbyButton({Key? key, required this.lecture}) : super(key: key);

  @override
  _QuizLobbyButtonState createState() => _QuizLobbyButtonState();
}

class _QuizLobbyButtonState extends State<QuizLobbyButton> {
  bool isLobbyOpen = false;

  @override
  void initState() {
    isLobbyOpen = widget.lecture.isLobbyOpen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: widget.lecture.isLobbyOpen
                ? MaterialStateProperty.all<Color>(Colors.red)
                : MaterialStateProperty.all<Color>(Colors.blueAccent)),
        onPressed: () {
          if (widget.lecture.isLobbyOpen) {
            setState(() {
              isLobbyOpen = true;
            });

            QuizService.dissalowParticipantsToJoinLobby(widget.lecture.id);
          } else {
            setState(() {
              isLobbyOpen = false;
            });
            QuizService.allowParticipantsToJoinLobby(widget.lecture.id);
          }
        },
        child: Text('Allow entry to lobby'));
  }
}
