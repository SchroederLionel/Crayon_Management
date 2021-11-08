import 'package:crayon_management/datamodels/custom_locale.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/l10n/l10n.dart';
import 'package:crayon_management/providers/util_providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return DropdownButton(
      value: localeProvider.getLocal,
      icon: Container(
        child: const Icon(
          Icons.arrow_drop_down,
        ),
        margin: const EdgeInsets.only(left: 5),
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (_) {},
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      items: AppLocalizations.languages.map((CustomLocale locale) {
        final String flag = L10n.getFlag(locale.languageCode);
        return DropdownMenuItem(
          value: locale,
          child: Text(
            flag,
            style: const TextStyle(fontSize: 24),
          ),
          onTap: () {
            localeProvider
                .setLocale(CustomLocale(languageCode: locale.languageCode));
          },
        );
      }).toList(),
    );
  }
}
