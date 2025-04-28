import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';

class LocaleListener extends StatefulWidget {
  final Locale defaultLocale;
  final Widget Function(ValueNotifier<Locale>) child;

  const LocaleListener({
    super.key,
    this.defaultLocale = const Locale('en_US'),
    required this.child,
  });

  @override
  State<LocaleListener> createState() => _LocaleListenerState();
}

class _LocaleListenerState extends State<LocaleListener>
    with WidgetsBindingObserver {
  ValueNotifier<Locale> currentLocale = ValueNotifier(
    Locale(Platform.localeName),
  );
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    currentLocale.value = locales?.first ?? widget.defaultLocale;

    DynamicLocalization.init(currentLocale.value);

    asyncPrefs.setString(
      "language_code",
      currentLocale.value.languageCode.toString(),
    );

    rebuildAllChildren(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(currentLocale);
  }
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
