// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get current_delivery => 'Aktuelle Lieferung';

  @override
  String get capacity => 'Kapazität';

  @override
  String get capacity_ah => 'Kapazität Ah';

  @override
  String get no_config_applied => 'Keine Konfiguration angewendet';

  @override
  String get reconnecting_to_server => 'Verbindung wird wiederhergestellt';

  @override
  String get no_config_found => 'Keine Konfiguration gefunden';

  @override
  String get last_change_before => 'Letzte Änderung vor';

  @override
  String get day_short => 'T';

  @override
  String get hour_short => 'S';

  @override
  String get minute_short => 'M';

  @override
  String get second_short => 'Z';
}
