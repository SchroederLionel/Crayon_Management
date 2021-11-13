import 'package:crayon_management/providers/user/user_lectures_provider.dart';
import 'package:crayon_management/screens/dashboard/components/lecture_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureList extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  const LectureList(
      {required this.crossAxisCount, required this.childAspectRatio, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserLectureProvider>(builder: (_, userLecture, __) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: userLecture.lectures.length,
        itemBuilder: (context, index) {
          return LectureInfoCard(
            lecture: userLecture.lectures[index],
          );
        },
      );
    });
  }
}
