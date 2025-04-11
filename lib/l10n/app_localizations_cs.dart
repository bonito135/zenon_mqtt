// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get current_delivery => 'Aktuální dodávka';

  @override
  String get capacity => 'Kapacita';

  @override
  String get capacity_ah => 'Kapacita Ah';

  @override
  String get no_config_applied => 'Žádná konfigurace aplikována';

  @override
  String get reconnecting_to_server => 'Znovu se připojuje k serveru';

  @override
  String get no_config_found => 'Nenalezena žádná konfigurace';

  @override
  String get last_change_before => 'Poslední změna před';

  @override
  String get day_short => 'd';

  @override
  String get hour_short => 'h';

  @override
  String get minute_short => 'm';

  @override
  String get second_short => 's';
}
