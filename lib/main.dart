import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenon_mqtt/core/localizations/default_lang_locale.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/core/localizations/locale_listenable.dart';
import 'package:zenon_mqtt/core/theme/theme.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/database/viewmodel/config.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/settings_bottom_sheet.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/dynamic_config_structure.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: LocaleListener(
        defaultLocale: Locale(Platform.localeName),
        child: (localeNotifier) => MyApp(localeNotifier: localeNotifier),
      ),
      dispose: (context, db) => db.close(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.localeNotifier});

  final ValueNotifier<Locale> localeNotifier;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DynamicLocalization.init(widget.localeNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.localeNotifier,
      builder: (context, locale, child) {
        DynamicLocalization.init(locale);
        return MaterialApp(
          title: 'Zenon MQTT',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: defaultLangLocale(locale),
          theme: theme,
          home: MyHomePage(localeNotifier: widget.localeNotifier),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.localeNotifier});

  final ValueNotifier<Locale> localeNotifier;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  MqttConnectionRepository<ConfigStructure>? configConnection;

  int currentPageIndex = 0;

  Future<void> setLastConfigTopic(String topic) async {
    return await asyncPrefs.setString("last_config_topic", topic);
  }

  Future<String?> getLastConfigTopic() async {
    return await asyncPrefs.getString("last_config_topic");
  }

  void setConfig(String? topic) async {
    if (topic != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await setLastConfigTopic(topic);
        setState(() {
          configConnection = MqttConnectionRepository<ConfigStructure>(
            client: MqttServerClient(
              dotenv.env['MQTT_SERVER_PROVIDER']!,
              'Mqtt_config',
            ),
            topic: topic,
            connMess: MqttConnectMessage(),
            autoReconnect: true,
            secure: false,
          );
        });
      });
    }
  }

  Future<void> setConfigBasedOnLastTopic() async {
    final configTopic = await getLastConfigTopic();
    if (configTopic != null) {
      setConfig(configTopic);
    }
  }

  void showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        return SettingsBottomSheet(
          setConfig: setConfig,
          setLocale:
              (locale) => {
                setState(() {
                  widget.localeNotifier.value = locale;
                }),
              },
        );
      },
    );
  }

  @override
  void initState() {
    setConfigBasedOnLastTopic();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    configConnection?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          configConnection?.stateNotifier ??
          ValueNotifier(MqttConnectionState.disconnected),
      builder: (context, value, child) {
        final MqttConnectionState connectionState = value;
        if (connectionState == MqttConnectionState.disconnected) {
          configConnection?.connect();
        }
        if (connectionState == MqttConnectionState.connected) {
          configConnection?.listen();
        }
        return ValueListenableBuilder(
          valueListenable:
              configConnection?.messageNotifier ?? ValueNotifier(null),
          builder: (context, value, child) {
            return FutureBuilder(
              future:
                  connectionState == MqttConnectionState.connected
                      ? writeAndReturnConfigStructure(
                        context.watch<AppDatabase>(),
                        value,
                      )
                      : readConfigStructure(context.watch<AppDatabase>()),
              builder: (context, snapshot) {
                final configStructure = snapshot.data;
                return DynamicConfigStructure(
                  connectionState: connectionState,
                  configStructure: configStructure,
                  showSettings: showSettingsSheet,
                );
              },
            );
          },
        );
      },
    );
  }
}
