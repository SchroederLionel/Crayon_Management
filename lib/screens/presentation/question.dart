import 'package:crayon_management/services/question_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Question extends StatelessWidget {
  final String lectureId;
  Question({required this.lectureId, Key? key}) : super(key: key);
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var questionList = Provider.of<List<String>>(context);

    return questionList.isNotEmpty
        ? IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            QuestionService.removeQuestion(
                                lectureId, questionList);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Answerd the question!'),
                        )
                      ],
                      title: Text(
                        'Question from Student (${questionList.length})',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      content: SizedBox(
                        height: 300,
                        width: 850,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            questionList.length > 1
                                ? IconButton(
                                    onPressed: () {
                                      if (currentIndex > 0) {
                                        currentIndex--;
                                        itemScrollController.scrollTo(
                                            index: currentIndex,
                                            duration: const Duration(
                                                milliseconds: 250),
                                            curve: Curves.easeInOutCubic);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_left,
                                      size: 14,
                                      color: Colors.white24,
                                    ))
                                : Container(),
                            SizedBox(
                              width: 770,
                              height: 300,
                              child: ScrollablePositionedList.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                initialScrollIndex: currentIndex,
                                itemCount: questionList.length,
                                itemBuilder: (context, index) => Container(
                                    width: 770,
                                    height: 300,
                                    child: Center(
                                        child: Text(
                                      questionList[index],
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ))),
                                itemScrollController: itemScrollController,
                                itemPositionsListener: itemPositionsListener,
                              ),
                            ),
                            questionList.length > 1
                                ? IconButton(
                                    onPressed: () {
                                      if (currentIndex < questionList.length) {
                                        currentIndex++;
                                        itemScrollController.scrollTo(
                                            index: currentIndex,
                                            duration: const Duration(
                                                milliseconds: 250),
                                            curve: Curves.easeInOutCubic);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_right,
                                      size: 14,
                                      color: Colors.white24,
                                    ))
                                : Container(),
                          ],
                        )),
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.notification_add,
              color: Colors.yellowAccent,
            ))
        : Container();
  }
}
