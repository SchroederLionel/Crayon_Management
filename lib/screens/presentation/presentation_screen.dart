import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/providers/detailed_lecture_provider.dart';
import 'package:crayon_management/providers/slides_provider.dart';
import 'package:crayon_management/providers/quiz_list_provider.dart';
import 'package:crayon_management/screens/presentation/components/controls.dart';
import 'package:crayon_management/screens/presentation/components/powerpoints.dart';
import 'package:crayon_management/screens/presentation/components/quiz.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PresentationScreen extends StatefulWidget {
  final Lecture lecture;
  const PresentationScreen({required this.lecture, Key? key}) : super(key: key);

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  late Lecture lectureDetail;
  @override
  void initState() {
    super.initState();
    final lectureProvider =
        Provider.of<DetailedLectureProvider>(context, listen: false);
    lectureProvider.getLectureData(widget.lecture.id ?? '');
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
                    widget.lecture.title ?? '',
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
              //  Controls(),
              const SizedBox(
                height: 14,
              ),
              ListenableProvider<QuizListProvider>(
                create: (context) => QuizListProvider(),
                child: const Quiz(),
              ),
              const SizedBox(
                height: 14,
              ),

              Consumer<DetailedLectureProvider>(
                  builder: (context, lectureProvider, child) {
                if (lectureProvider.lecture != null) {
                  return Powerpoints(
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
