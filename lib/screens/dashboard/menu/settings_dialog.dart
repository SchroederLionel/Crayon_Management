import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/util_providers/theme_provider.dart';
import 'package:crayon_management/widgets/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LanguageWidget(),
            ElevatedButton.icon(
                onPressed: () => themeProvider.swapTheme(),
                icon: const Icon(Icons.lightbulb_outline),
                label: Text(
                    appTranslation!.translate('brightness') ?? 'Brightness'))
          ],
        ),
      ),
    );
  }
}
