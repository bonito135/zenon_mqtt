// import 'dart:io';
// import 'package:sqlite3/sqlite3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/Indicator/sized_process_indicator.dart';
import 'package:zenon_mqtt/components/page/dynamic_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zenon_mqtt/db/db.dart';
import 'package:zenon_mqtt/db/functions/index.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: MyApp(),
      dispose: (context, db) => db.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenon MQTT',
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
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final configConnection = MqttConnection(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    dotenv.env['MQTT_CONFIG_TOPIC']!,
    MqttConnectMessage().withClientIdentifier('Mqtt_config').startClean(),
  );

  int currentPageIndex = 0;

  Future<void> reconnect() async {
    await configConnection.connect();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reconnect();
    });
  }

  @override
  void dispose() {
    super.dispose();

    configConnection.client.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: configConnection.stateNotifier,
      builder: (context, value, child) {
        final connectionState = value;

        if (value == MqttConnectionState.connected) {
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
                  ConfigStructure configStructure =
                      snapshot.data as ConfigStructure;
                  return Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      title: Text(
                        configStructure.structure[currentPageIndex].sectionName,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    bottomNavigationBar: SafeArea(
                      child:
                          configStructure.structure.length < 2
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
                                  configStructure.structure.length,
                                  (index) => NavigationDestination(
                                    icon: Icon(Icons.explore),
                                    label:
                                        configStructure
                                            .structure[index]
                                            .sectionName,
                                  ),
                                ),
                              ),
                    ),
                    body: SafeArea(
                      child:
                          configStructure.structure.isEmpty
                              ? Center(child: Text("No configuration applied"))
                              : DynamicPage(
                                title: Text(
                                  configStructure
                                      .structure[currentPageIndex]
                                      .sectionName,
                                ),
                                structure:
                                    configStructure.structure[currentPageIndex],
                              ),
                    ),
                  );
                }

                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  body: Center(child: SizedProcessIndicator()),
                );
              },
            );
          },
        );
      },
    );
  }
}
