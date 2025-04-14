import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('cs'),
    Locale('de')
  ];

  /// Current delivery of the ZenonMQTTPublisher/BMS/PV.DC.Total_PV_Input_Power MQTT topic
  ///
  /// In en, this message translates to:
  /// **'Current delivery'**
  String get current_delivery;

  /// Capacity of the ZenonMQTTPublisher/BMS/PV.Battery.SOC MQTT topic
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// Capacity of the ZenonMQTTPublisher/BMS/PV.Battery.SOCAbs MQTT topic
  ///
  /// In en, this message translates to:
  /// **'Capacity Ah'**
  String get capacity_ah;

  /// No configuration applied
  ///
  /// In en, this message translates to:
  /// **'No configuration applied'**
  String get no_config_applied;

  /// Reconnecting to server
  ///
  /// In en, this message translates to:
  /// **'Reconnecting to server'**
  String get reconnecting_to_server;

  /// No configuration found
  ///
  /// In en, this message translates to:
  /// **'No configuration found'**
  String get no_config_found;

  /// Last change before
  ///
  /// In en, this message translates to:
  /// **'Last change before'**
  String get last_change_before;

  /// Day short
  ///
  /// In en, this message translates to:
  /// **'d'**
  String get day_short;

  /// Hour short
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hour_short;

  /// Minute short
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get minute_short;

  /// Second short
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get second_short;

  /// Topic
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// Language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Apply
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Applied
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// Submit
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Processing Data
  ///
  /// In en, this message translates to:
  /// **'Processing Data'**
  String get processing_data;

  /// Connection topic
  ///
  /// In en, this message translates to:
  /// **'Connection topic'**
  String get connection_topic;

  /// Connection topic is required
  ///
  /// In en, this message translates to:
  /// **'Connection topic is required'**
  String get connection_topic_is_required;

  /// Connect to Zenon istance
  ///
  /// In en, this message translates to:
  /// **'Connect to Zenon istance'**
  String get connect_to_zenon_instace;

  /// Unknown type
  ///
  /// In en, this message translates to:
  /// **'Unknown type'**
  String get unknown_type;

  /// Photovoltaics
  ///
  /// In en, this message translates to:
  /// **'Photovoltaics'**
  String get photovoltaics;

  /// Temperatures
  ///
  /// In en, this message translates to:
  /// **'Temperatures'**
  String get temperatures;

  /// Battery temperature
  ///
  /// In en, this message translates to:
  /// **'Battery temperature'**
  String get battery_temperature;

  /// Total power load
  ///
  /// In en, this message translates to:
  /// **'Total power load'**
  String get total_power_load;

  /// Battery current
  ///
  /// In en, this message translates to:
  /// **'Battery current'**
  String get battery_current;

  /// Battery voltage
  ///
  /// In en, this message translates to:
  /// **'Battery voltage'**
  String get battery_voltage;

  /// Battery mode
  ///
  /// In en, this message translates to:
  /// **'Battery mode'**
  String get battery_mode;

  /// Temperature sensor presentation room
  ///
  /// In en, this message translates to:
  /// **'Presentation room'**
  String get temperature_sensor_presentation_room;

  /// Temperature sensor secretariat
  ///
  /// In en, this message translates to:
  /// **'Secretariat'**
  String get temperature_sensor_secretariat;

  /// Temperature sensor technicians
  ///
  /// In en, this message translates to:
  /// **'Technicians'**
  String get temperature_sensor_technicians;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['cs', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs': return AppLocalizationsCs();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
