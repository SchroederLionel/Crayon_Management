import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';

import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/add_lecture_dialog.dart';
import 'package:crayon_management/screens/dashboard/components/lecture_info_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Lectures extends StatelessWidget {
  const Lectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translation!.myLectures,
              style: Theme.of(context).textTheme.headline2,
            ),
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical:
                            14.0 / (Responsive.isMobile(context) ? 2 : 1))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MultiProvider(providers: [
                          ChangeNotifierProvider<LectureDateProvider>(
                            create: (_) => LectureDateProvider(),
                          ),
                          ChangeNotifierProvider<DropDownDayProvider>(
                            create: (context) => DropDownDayProvider(),
                          )
                        ], child: const AddLectureDialog());
                      });
                },
                icon: const Icon(Icons.add),
                label: Text(translation.addLecture)),
          ],
        ),
      ],
    );
  }
}

class LectureInfoCardGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const LectureInfoCardGridView(
      {Key? key, this.crossAxisCount = 4, this.childAspectRatio = 1.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final myLectures = userProvider.getMyLectures;

    if (myLectures == null) {
      return Container();
    } else {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: userProvider.getMyLectures!.length,
        itemBuilder: (context, index) {
          return LectureInfoCard(
            lecture: userProvider.getMyLectures![index],
          );
        },
      );
    }
  }
}
