import 'package:flutter/material.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class SettingsBottomSheetLocalization extends StatelessWidget {
  const SettingsBottomSheetLocalization({super.key, required this.setLocale});

  final Function(Locale) setLocale;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ...AppLocalizations.supportedLocales.map((locale) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.languageCode.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () => {setLocale(locale)},
                  child: Text(
                    currentLocale.languageCode.toLowerCase() ==
                            locale.languageCode.toLowerCase()
                        ? AppLocalizations.of(context)!.applied
                        : AppLocalizations.of(context)!.apply,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
