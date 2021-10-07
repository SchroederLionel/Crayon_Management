import 'package:crayon_management/l10n/l10n.dart';
import 'package:crayon_management/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return DropdownButton(
      value: locale,
      icon: Container(
        child: const Icon(
          Icons.arrow_drop_down,
        ),
        margin: EdgeInsets.only(left: 5),
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (_) {},
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      items: L10n.languages.map((Locale locale) {
        final String flag = L10n.getFlag(locale.languageCode);
        return DropdownMenuItem(
          value: locale,
          child: Text(
            flag,
            style: const TextStyle(fontSize: 24),
          ),
          onTap: () {
            localeProvider.setLocale(Locale(locale.languageCode));
          },
        );
      }).toList(),
    );
  }
}
