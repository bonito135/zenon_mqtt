// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get current_delivery => 'Aktuelle Leistung';

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
  String get second_short => 'S';

  @override
  String get topic => 'Thema';

  @override
  String get language => 'Sprache';

  @override
  String get apply => 'Anwenden';

  @override
  String get applied => 'Angewendet';

  @override
  String get submit => 'Absenden';

  @override
  String get processing_data => 'Datenverarbeitung';

  @override
  String get connection_server => 'Verbindungsserver';

  @override
  String get connection_topic => 'Verbindungsthema';

  @override
  String get connection_topic_is_required => 'Verbindungsthema ist erforderlich';

  @override
  String get connect_to_zenon_instace => 'Verbinden Sie mit Zenon-Instanz';

  @override
  String get unknown_type => 'Unbekannter Typ';

  @override
  String get photovoltaics => 'Photovoltaik';

  @override
  String get temperatures => 'Temperaturen';

  @override
  String get battery_temperature => 'Batterietemperatur';

  @override
  String get total_power_load => 'Aktueller Verbrauch';

  @override
  String get battery_current => 'Batteriestrom';

  @override
  String get battery_voltage => 'Batteriespannung';

  @override
  String get battery_mode => 'Batteriemodus';

  @override
  String get battery_charging => 'Batterieladung';

  @override
  String get presentation_room => 'Präsentationsraum';

  @override
  String get meeting_room => 'Besprechungsraum';

  @override
  String get secretariat => 'Sekretariat';

  @override
  String get business_room => 'Business room';

  @override
  String get technicians => 'Techniker';

  @override
  String connAckReturnCode(String returnCode) {
    String _temp0 = intl.Intl.selectLogic(
      returnCode,
      {
        'connectionAccepted': 'Verbindung akzeptiert',
        'unacceptedProtocolVersion': 'Verbindung abgelehnt, nicht akzeptable Protokollversion',
        'identifierRejected': 'Verbindung abgelehnt, Kennung zurückgewiesen',
        'brokerUnavailable': 'Verbindung abgelehnt, Server nicht verfügbar',
        'badUsernameOrPassword': 'Verbindung abgelehnt, falscher Benutzername oder falsches Passwort',
        'notAuthorized': 'Verbindung abgelehnt, nicht autorisiert',
        'noneSpecified': 'Unbekannter Rückkehrcode',
        'other': 'Unbekannter Rückkehrcode',
      },
    );
    return '$_temp0';
  }

  @override
  String get connection => 'Verbindung';

  @override
  String get public => 'Öffentlich';

  @override
  String get secure => 'Sicher';

  @override
  String get server_configuration_is_required => 'Serverkonfiguration ist erforderlich';

  @override
  String get username => 'Benutzername';

  @override
  String get password => 'Passwort';

  @override
  String get username_is_required => 'Benutzername ist erforderlich';

  @override
  String get password_is_required => 'Passwort ist erforderlich';
}
