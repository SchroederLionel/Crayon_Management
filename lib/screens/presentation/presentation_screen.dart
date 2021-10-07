import 'package:crayon_management/datamodels/lecture.dart';
import 'package:crayon_management/screens/presentation/components/controls.dart';
import 'package:crayon_management/screens/presentation/components/powerpoints.dart';
import 'package:crayon_management/screens/presentation/components/quiz.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PresentationScreen extends StatelessWidget {
  final Lecture lecture;
  const PresentationScreen({required this.lecture, Key? key}) : super(key: key);

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
                    lecture.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.redAccent,
                      ))
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Controls(),
              SizedBox(
                height: 14,
              ),
              Quiz(),
              SizedBox(
                height: 14,
              ),
              Powerpoints(),
            ],
          ),
        ),
      ),
    );
  }
}
