import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/providers/quiz/response_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/components/controls.dart';
import 'package:crayon_management/screens/detailed_lecture/components/slides_component.dart';
import 'package:crayon_management/screens/detailed_lecture/components/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class DetailedLectureScreen extends StatefulWidget {
  final LectureSnipped lecture;
  const DetailedLectureScreen({required this.lecture, Key? key})
      : super(key: key);

  @override
  State<DetailedLectureScreen> createState() => _DetailedLectureScreenState();
}

class _DetailedLectureScreenState extends State<DetailedLectureScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        Provider.of<DetailedLectureProvider>(context, listen: false)
            .getLecture(widget.lecture.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.lecture.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.redAccent,
                      ))
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Consumer<DetailedLectureProvider>(
                builder: (_, lectureNotifier, __) {
                  if (lectureNotifier.state == NotifierState.initial) {
                    return Container();
                  } else if (lectureNotifier.state == NotifierState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return lectureNotifier.lectureD.fold(
                        (failure) => Center(child: Text(failure.toString())),
                        (lecture) => lecture == null
                            ? Container()
                            : lecture.slides.isEmpty
                                ? Container()
                                : Controls(
                                    lectureId: lecture.id,
                                    slides: lecture.slides,
                                  ));
                  }
                },
              ),
              const SizedBox(
                height: 14,
              ),
              ListenableProvider<QuizProvider>(
                create: (context) => QuizProvider(),
                child: const Quiz(),
              ),
              const SizedBox(
                height: 14,
              ),
              Consumer<DetailedLectureProvider>(
                  builder: (_, lectureNotifier, __) {
                if (lectureNotifier.state == NotifierState.initial) {
                  return Container();
                } else if (lectureNotifier.state == NotifierState.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return lectureNotifier.lectureD.fold(
                      (failure) => Text(failure.toString()),
                      (lecture) => lecture == null
                          ? Container()
                          : SlidesComponent(
                              lecture: lecture,
                            ));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
