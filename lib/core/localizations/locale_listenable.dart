import 'package:flutter/material.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';

class LocaleListener extends StatefulWidget {
  final Locale defaultLocale;
  final Widget? child;

  const LocaleListener({
    super.key,
    this.defaultLocale = const Locale('en_US'),
    this.child,
  });

  @override
  State<LocaleListener> createState() => _LocaleListenerState();
}

class _LocaleListenerState extends State<LocaleListener>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    final currentLocale = locales?.first ?? widget.defaultLocale;

    // log("Locale changed to: $currentLocale");

    DynamicLocalization.init(currentLocale);

    rebuildAllChildren(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
