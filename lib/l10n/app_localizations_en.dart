// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get current_delivery => 'Current delivery';

  @override
  String get capacity => 'Capacity';

  @override
  String get capacity_ah => 'Capacity Ah';

  @override
  String get no_config_applied => 'No configuration applied';

  @override
  String get reconnecting_to_server => 'Reconnecting to server';

  @override
  String get no_config_found => 'No configuration found';

  @override
  String get last_change_before => 'Last change before';

  @override
  String get day_short => 'd';

  @override
  String get hour_short => 'h';

  @override
  String get minute_short => 'm';

  @override
  String get second_short => 's';
}
