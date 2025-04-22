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

  @override
  String get topic => 'Téma';

  @override
  String get language => 'Jazyk';

  @override
  String get apply => 'Použít';

  @override
  String get applied => 'Použito';

  @override
  String get submit => 'Odeslat';

  @override
  String get processing_data => 'Zpracování dat';

  @override
  String get connection_server => 'Připojení serveru';

  @override
  String get connection_topic => 'Připojení tématu';

  @override
  String get connection_topic_is_required => 'Je vyžadován připojení tématu';

  @override
  String get connect_to_zenon_instace => 'Připojte se k instanci Zenonu';

  @override
  String get unknown_type => 'Neznámý typ';

  @override
  String get photovoltaics => 'Fotovoltaika';

  @override
  String get temperatures => 'Teploty';

  @override
  String get battery_temperature => 'Teplota baterie';

  @override
  String get total_power_load => 'Celkový výkon';

  @override
  String get battery_current => 'Proud baterie';

  @override
  String get battery_voltage => 'Napětí baterie';

  @override
  String get battery_mode => 'Mód baterie';

  @override
  String get battery_charging => 'Nabíjení batterie';

  @override
  String get presentation_room => 'Prezentační místnost';

  @override
  String get meeting_room => 'Zasedací místnost';

  @override
  String get secretariat => 'Sekretariát';

  @override
  String get business_room => 'Obchod';

  @override
  String get technicians => 'Technici';

  @override
  String connAckReturnCode(String returnCode) {
    String _temp0 = intl.Intl.selectLogic(
      returnCode,
      {
        'connectionAccepted': 'Připojení přijato',
        'unacceptedProtocolVersion': 'Připojení odmítnuto, nepřijatelná verze protokolu',
        'identifierRejected': 'Připojení odmítnuto, identifikátor zamítnut',
        'brokerUnavailable': 'Připojení odmítnuto, server nedostupný',
        'badUsernameOrPassword': 'Připojení odmítnuto, špatné uživatelské jméno nebo heslo',
        'notAuthorized': 'Připojení odmítnuto, není autorizováno',
        'noneSpecified': 'Neznámý návratový kód',
        'other': 'Neznámý návratový kód',
      },
    );
    return '$_temp0';
  }

  @override
  String get connection => 'Připojení';

  @override
  String get public => 'Veřejné';

  @override
  String get secure => 'Zabezpečené';

  @override
  String get server_configuration_is_required => 'Je vyžadována konfigurace serveru';

  @override
  String get username => 'Uživatelské jméno';

  @override
  String get password => 'Heslo';

  @override
  String get username_is_required => 'Uživatelské jméno je vyžadováno';

  @override
  String get password_is_required => 'Heslo je vyžadováno';
}
