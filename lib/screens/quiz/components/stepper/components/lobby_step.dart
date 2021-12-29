import 'package:crayon_management/services/quiz_service.dart';
import 'package:crayon_management/widgets/custom_text.dart';
import 'package:crayon_management/widgets/error_text.dart';
import 'package:crayon_management/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LobbyStep extends StatelessWidget {
  final String lectureId;
  const LobbyStep({Key? key, required this.lectureId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<String>>(
        stream: QuizService.getQuizParticiants(lectureId),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const ErrorText(
              error: 'Failure',
            );
          } else if (snapshot.data == null) {
            return const Center(
                child: CustomText(
                    safetyText:
                        'Their are currently no participants to the quiz',
                    textCode: 'no-participants'));
          } else {
            List<String> participants = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height - 300,
                  child: Card(
                    child: Center(
                      child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 4,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemCount: participants.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Text(
                                participants[index],
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
