import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizLobby extends StatelessWidget {
  const QuizLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<List<String>>(builder: (context, participants, child) {
      return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: participants.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(participants[index]));
            }),
      );
    });
  }
}
