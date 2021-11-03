import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';
import 'package:crayon_management/providers/lecture/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/quiz/quiz_provider.dart';
import 'package:crayon_management/providers/quiz/response_provider.dart';
import 'package:crayon_management/screens/detailed_lecture/components/controls.dart';
import 'package:crayon_management/screens/detailed_lecture/components/slides_component.dart';
import 'package:crayon_management/screens/detailed_lecture/components/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedLectureScreen extends StatefulWidget {
  final LectureSnipped lecture;
  const DetailedLectureScreen({required this.lecture, Key? key})
      : super(key: key);

  @override
  State<DetailedLectureScreen> createState() => _DetailedLectureScreenState();
}

class _DetailedLectureScreenState extends State<DetailedLectureScreen> {
  late Lecture lectureDetail;
  @override
  void initState() {
    super.initState();
    final lectureProvider =
        Provider.of<DetailedLectureProvider>(context, listen: false);
    lectureProvider.getLectureData(widget.lecture.id);
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
                builder: (context, detailedLecture, child) {
                  if (detailedLecture.lecture == null) {
                    return Container();
                  }
                  if (detailedLecture.lecture!.slides.isNotEmpty) {
                    return Controls(
                      lecture: detailedLecture.lecture!,
                    );
                  }
                  return Container();
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
                  builder: (context, lectureProvider, child) {
                if (lectureProvider.lecture != null) {
                  return SlidesComponent(
                    lecture: lectureProvider.lecture!,
                  );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
