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

  @override
  String get topic => 'Topic';

  @override
  String get language => 'Language';

  @override
  String get apply => 'Apply';

  @override
  String get applied => 'Applied';

  @override
  String get submit => 'Submit';

  @override
  String get processing_data => 'Processing Data';

  @override
  String get connection_server => 'Connection server';

  @override
  String get connection_topic => 'Connection topic';

  @override
  String get connection_topic_is_required => 'Connection topic is required';

  @override
  String get connect_to_zenon_instace => 'Connect to Zenon istance';

  @override
  String get unknown_type => 'Unknown type';

  @override
  String get photovoltaics => 'Photovoltaics';

  @override
  String get temperatures => 'Temperatures';

  @override
  String get battery_temperature => 'Battery temperature';

  @override
  String get total_power_load => 'Total power load';

  @override
  String get battery_current => 'Battery current';

  @override
  String get battery_voltage => 'Battery voltage';

  @override
  String get battery_mode => 'Battery mode';

  @override
  String get temperature_sensor_presentation_room => 'Presentation room';

  @override
  String get temperature_sensor_secretariat => 'Secretariat';

  @override
  String get temperature_sensor_technicians => 'Technicians';

  @override
  String connAckReturnCode(String returnCode) {
    String _temp0 = intl.Intl.selectLogic(
      returnCode,
      {
        'connectionAccepted': 'Connection accepted',
        'unacceptedProtocolVersion': 'Connection refused, unacceptable protocol version',
        'identifierRejected': 'Connection refused, identifier rejected',
        'brokerUnavailable': 'Connection refused, server unavailable',
        'badUsernameOrPassword': 'Connection refused, bad user name or password',
        'notAuthorized': 'Connection refused, not authorized',
        'noneSpecified': 'Unknown return code',
        'other': 'Unknown return code',
      },
    );
    return '$_temp0';
  }

  @override
  String get connection => 'Connection';

  @override
  String get public => 'Public';

  @override
  String get secure => 'Secure';

  @override
  String get server_configuration_is_required => 'Server configuration is required';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get username_is_required => 'Username is required';

  @override
  String get password_is_required => 'Password is required';
}
