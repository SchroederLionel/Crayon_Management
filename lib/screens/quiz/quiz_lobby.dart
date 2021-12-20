import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizLobby extends StatelessWidget {
  const QuizLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<List<String>>(builder: (context, participants, child) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4,
                    crossAxisCount: 4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      participants[index],
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }
}