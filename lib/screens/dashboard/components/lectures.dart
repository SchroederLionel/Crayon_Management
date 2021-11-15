import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/datamodels/lecture/lecture.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:crayon_management/providers/lecture/drop_down_type_provider.dart';
import 'package:crayon_management/providers/lecture/lecture_date_provider.dart';
import 'package:crayon_management/providers/lecture/time_picker_provider.dart';
import 'package:crayon_management/providers/user/user_provider.dart';
import 'package:crayon_management/providers/user/user_lectures_provider.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/add_modify_lecture_components/add_lecture_dialog.dart';
import 'package:crayon_management/screens/dashboard/components/lecture_list.dart';
import 'package:crayon_management/widgets/error_text.dart';
import 'package:crayon_management/widgets/loading_widget.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Lectures extends StatelessWidget {
  const Lectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appTranslation!.translate('myLectures') ?? 'My Lectures',
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
                        return MultiProvider(
                            providers: [
                              ChangeNotifierProvider<LectureDateProvider>(
                                create: (_) => LectureDateProvider(),
                              ),
                              ChangeNotifierProvider<DropDownDayProvider>(
                                create: (context) => DropDownDayProvider(),
                              ),
                              ChangeNotifierProvider<TimePickerProvider>(
                                create: (context) => TimePickerProvider(),
                              ),
                              ChangeNotifierProvider<DropDownTypeProvider>(
                                create: (context) => DropDownTypeProvider(),
                              )
                            ],
                            child: const AddLectureDialog(
                              lectureSnipped: null,
                            ));
                      }).then((value) {
                    if (value is Lecture) {
                      Provider.of<UserLectureProvider>(context, listen: false)
                          .addLecture(value);
                    }
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(
                    appTranslation.translate('addLecture') ?? 'Add Lecture')),
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
    return Consumer<UserProvider>(builder: (_, userProvider, __) {
      if (userProvider.state == NotifierState.initial) {
        return Container();
      } else if (userProvider.state == NotifierState.loading) {
        return const LoadingWidget();
      } else if (userProvider.state == NotifierState.loaded) {
        return userProvider.user.fold(
            (failure) => Center(
                  child: ErrorText(
                    error: failure.code,
                  ),
                ), (userData) {
          WidgetsBinding.instance!.addPostFrameCallback((_) =>
              Provider.of<UserLectureProvider>(context, listen: false)
                  .setLectures(userData.myLectures));
          return LectureList(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio);
        });
      } else {
        return const Center(
            child: ErrorText(
          error: 'something-went-wrong',
        ));
      }
    });
  }
}
