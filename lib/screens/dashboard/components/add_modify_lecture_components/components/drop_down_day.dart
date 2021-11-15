import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/drop_down_day_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownDay extends StatelessWidget {
  const DropDownDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: Consumer<DropDownDayProvider>(
          builder: (context, dropProvider, __) {
            if (dropProvider.state == NotifierState.initial) {
              WidgetsBinding.instance!
                  .addPostFrameCallback((_) => dropProvider.setUp(null));

              return Container();
            }

            return DropdownButton<String>(
                onChanged: (String? day) {
                  if (day != null) {
                    dropProvider.setWeekDay(day);
                  }
                },
                value: dropProvider.currentWeekDay,
                style: Theme.of(context).textTheme.bodyText1,
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 18,
                items: dropProvider.weekDays
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(appTranslation!.translate(value) ?? value),
                  );
                }).toList());
          },
        ));
  }
}
