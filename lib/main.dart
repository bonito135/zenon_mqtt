import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:zenon_mqtt/core/localizations/default_lang_locale.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/core/localizations/locale_listenable.dart';
import 'package:zenon_mqtt/core/theme/theme.dart';
import 'package:zenon_mqtt/core/view/widgets/sized_process_indicator.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/database/viewmodel/config.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/config_structure_bottom_sheet.dart';
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
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Zenon MQTT',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: defaultLangLocale(value),
          theme: theme,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MqttConnectionRepository<ConfigStructure>? configConnection;

  int currentPageIndex = 0;

  @override
  void dispose() {
    super.dispose();

    configConnection?.dispose();
  }

  void setConfig(String? topic) {
    log("Set config: $topic");
    if (topic != null) {
      setState(() {
        configConnection = MqttConnectionRepository<ConfigStructure>(
          MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
          topic,
          MqttConnectMessage().withClientIdentifier('Mqtt_config').startClean(),
        );
      });
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        return ConfigStructureBottomSheet(setConfig: setConfig);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (configConnection == null) {
      return DynamicConfigStructure(
        configStructure: null,
        currentPageIndex: currentPageIndex,
        showBottomSheet: showBottomSheet,
        setPageIndex: (index) => {currentPageIndex = index},
      );
    }
    return ValueListenableBuilder(
      valueListenable: configConnection!.stateNotifier,
      builder: (context, value, child) {
        final MqttConnectionState connectionState = value;
        if (connectionState == MqttConnectionState.disconnected) {
          configConnection!.connect();
        }
        if (connectionState == MqttConnectionState.connected) {
          configConnection!.listen();
        }
        return ValueListenableBuilder(
          valueListenable: configConnection!.messageNotifier,
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
                if (snapshot.hasData && snapshot.data != null) {
                  final configStructure = snapshot.data!;
                  return DynamicConfigStructure(
                    configStructure: configStructure,
                    currentPageIndex: currentPageIndex,
                    showBottomSheet: showBottomSheet,
                    setPageIndex: (index) => {currentPageIndex = index},
                  );
                }
                return DynamicConfigStructure(
                  configStructure: null,
                  currentPageIndex: currentPageIndex,
                  showBottomSheet: showBottomSheet,
                  setPageIndex: (index) => {currentPageIndex = index},
                );
              },
            );
          },
        );
      },
    );
  }
}
