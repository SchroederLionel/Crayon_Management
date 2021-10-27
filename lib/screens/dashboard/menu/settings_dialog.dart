import 'package:crayon_management/providers/util_providers/locale_provider.dart';
import 'package:crayon_management/providers/util_providers/theme_provider.dart';
import 'package:crayon_management/widgets/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LanguageWidget(forStartingPage: true),
            ElevatedButton.icon(
                onPressed: () => themeProvider.swapTheme(),
                icon: const Icon(Icons.lightbulb_outline),
                label: Text(translation!.brightness))
          ],
        ),
      ),
    );
  }
}
