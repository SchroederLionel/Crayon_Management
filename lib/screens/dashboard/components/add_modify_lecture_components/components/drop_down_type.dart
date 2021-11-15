import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/lecture/drop_down_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownType extends StatelessWidget {
  const DropDownType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return Consumer<DropDownTypeProvider>(
        builder: (_, dropDownTypeProvider, __) {
      return Container(
        margin: const EdgeInsets.only(top: 25),
        child: DropdownButton<String>(
            value: dropDownTypeProvider.currentType,
            onChanged: (String? type) {
              if (type != null) {
                dropDownTypeProvider.setCurrentType(type);
              }
            },
            style: Theme.of(context).textTheme.bodyText1,
            underline: Container(
              height: 2,
              color: Colors.blueAccent,
            ),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 18,
            items: <String>[
              'lecture',
              'exercise',
              'other',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(appTranslation!.translate(value) ?? 'error'),
              );
            }).toList()),
      );
    });
  }
}
