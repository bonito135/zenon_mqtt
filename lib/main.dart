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
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/settings_bottom_sheet.dart';
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

  Future<MqttConnectionRepository<ConfigStructure>> getLastConfig() async {
    final server = await asyncPrefs.getString("last_config_server") ?? "";
    final clientIdentifier =
        await asyncPrefs.getString("last_config_client_identifier") ?? "";
    final topic = await asyncPrefs.getString("last_config_topic") ?? "";
    final autoReconnect =
        await asyncPrefs.getBool("last_config_auto_reconnect") ?? false;
    final secure = await asyncPrefs.getBool("last_config_secure") ?? false;
    final username = await asyncPrefs.getString("last_config_username") ?? "";
    final password = await asyncPrefs.getString("last_config_password") ?? "";

    if (secure) {
      return MqttConnectionRepository<ConfigStructure>(
        client: MqttServerClient(server, clientIdentifier),
        topic: topic,
        connMess: MqttConnectMessage(),
        autoReconnect: autoReconnect,
        secure: secure,
        username: username,
        password: password,
      );
    }

    return MqttConnectionRepository<ConfigStructure>(
      client: MqttServerClient(server, clientIdentifier),
      topic: topic,
      connMess: MqttConnectMessage(),
      autoReconnect: autoReconnect,
      secure: secure,
    );
  }

  Future<void> setLastConfig(
    MqttConnectionRepository<ConfigStructure> config,
  ) async {
    await asyncPrefs.setString("last_config_server", config.client.server);
    await asyncPrefs.setString(
      "last_config_client_identifier",
      config.client.clientIdentifier,
    );
    await asyncPrefs.setString("last_config_topic", config.topic);
    await asyncPrefs.setBool(
      "last_config_auto_reconnect",
      config.autoReconnect,
    );
    await asyncPrefs.setBool("last_config_secure", config.secure);
    await asyncPrefs.setString("last_config_username", config.username ?? "");
    await asyncPrefs.setString("last_config_password", config.password ?? "");
  }

  Future<void> setConfig(
    MqttConnectionRepository<ConfigStructure> config,
  ) async {
    return WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      configConnection?.dispose();
      await setLastConfig(config);

      setState(() {
        configConnection = config;
      });
    });
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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final config = await getLastConfig();
      setConfig(config);
    });
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
          ValueNotifier(
            MqttClientConnectionStatus()
              ..state = MqttConnectionState.disconnected
              ..returnCode = MqttConnectReturnCode.noneSpecified
              ..disconnectionOrigin = MqttDisconnectionOrigin.none
              ..connectAckMessage = null,
          ),
      builder: (context, value, child) {
        final MqttClientConnectionStatus connectionState = value;
        if (connectionState.state == MqttConnectionState.disconnected) {
          configConnection?.connect();
        }
        if (connectionState.state == MqttConnectionState.connected) {
          configConnection?.listen();
        }
        return ValueListenableBuilder(
          valueListenable:
              configConnection?.messageNotifier ?? ValueNotifier(null),
          builder: (context, value, child) {
            return FutureBuilder(
              future:
                  connectionState.state == MqttConnectionState.connected
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
