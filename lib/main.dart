import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:zenon_mqtt/core/localizations/default_lang_locale.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/core/localizations/locale_listenable.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/core/view/widgets/sized_process_indicator.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/pages/dynamic_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zenon_mqtt/features/database/viewmodel/index.dart';
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
    log("Locale: ${widget.localeNotifier}");
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
          localeResolutionCallback: (locale, supportedLocales) {
            log("Locale resolution callback $value");
            return defaultLangLocale(value);
          },
          theme: ThemeData(
            // Define the default brightness and colors.
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 2, 147, 144),
              primary: const Color.fromARGB(255, 0, 36, 51),
              secondary: const Color.fromARGB(255, 107, 165, 93),
              brightness: Brightness.light,
            ),

            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              titleLarge: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              displayLarge: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              bodyMedium: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              bodySmall: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
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
  late final configConnection = MqttConnectionRepository<ConfigStructure>(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    dotenv.env['MQTT_CONFIG_TOPIC']!,
    MqttConnectMessage().withClientIdentifier('Mqtt_config').startClean(),
  );

  int currentPageIndex = 0;

  @override
  void dispose() {
    super.dispose();

    configConnection.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: configConnection.stateNotifier,
      builder: (context, value, child) {
        final MqttConnectionState connectionState = value;
        if (connectionState == MqttConnectionState.disconnected) {
          configConnection.connect();
        }
        if (connectionState == MqttConnectionState.connected) {
          configConnection.listen();
        }
        return ValueListenableBuilder(
          valueListenable: configConnection.messageNotifier,
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
                  return Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      title: Text(
                        configStructure
                            .content!
                            .structure[currentPageIndex]
                            .sectionName,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    bottomNavigationBar: SafeArea(
                      child:
                          configStructure.content!.structure.length < 2
                              ? SizedBox.shrink()
                              : NavigationBar(
                                labelBehavior:
                                    NavigationDestinationLabelBehavior
                                        .alwaysShow,
                                selectedIndex: currentPageIndex,
                                onDestinationSelected: (int index) {
                                  setState(() {
                                    if (mounted) {
                                      currentPageIndex = index;
                                    }
                                  });
                                },
                                destinations: List<Widget>.generate(
                                  configStructure.content!.structure.length,
                                  (index) => NavigationDestination(
                                    icon: Icon(Icons.explore),
                                    label:
                                        configStructure
                                            .content!
                                            .structure[index]
                                            .sectionName,
                                  ),
                                ),
                              ),
                    ),
                    body: SafeArea(
                      child:
                          configStructure.content!.structure.isEmpty
                              ? Center(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.no_config_applied,
                                ),
                              )
                              : DynamicPage(
                                title: Text(
                                  configStructure
                                      .content!
                                      .structure[currentPageIndex]
                                      .sectionName,
                                ),
                                structure:
                                    configStructure
                                        .content!
                                        .structure[currentPageIndex],
                              ),
                    ),
                  );
                }
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        connectionState != MqttConnectionState.connected
                            ? Text(
                              AppLocalizations.of(
                                context,
                              )!.reconnecting_to_server,
                            )
                            : Text(
                              AppLocalizations.of(context)!.no_config_found,
                            ),
                        SizedProcessIndicator(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
