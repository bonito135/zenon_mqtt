import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/classes/connection.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/page/dynamic_page.dart';
import 'package:zenon_mqtt/data/init_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
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
  ConfigStructure configStructure = initConfigStructure;
  final configStorage = Storage("configStructure");

  void setConfig(String value) async {
    var decodedInit = jsonDecode(value) as List<dynamic>;
    if (decodedInit.isEmpty) {
      return;
    }

    setState(() {
      if (mounted) {
        configStructure = ConfigStructure.fromJson(decodedInit);
      }
    });
  }

  late final configConnection = MQTTConnection(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    dotenv.env['MQTT_CONFIG_TOPIC']!,
    MqttConnectMessage().withClientIdentifier('Mqtt_config'),
    // .startClean(), // Non persistent session for testing
    (String value) => setConfig(value),
    configStorage,
  );

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _getStorageConfigString();

    configConnection.init();
  }

  void _getStorageConfigString() async {
    String storageConfigString = await configStorage.readStorage() ?? "";

    if (storageConfigString != "") {
      setState(() {
        if (mounted) {
          configStructure = ConfigStructure.fromJson(
            jsonDecode(storageConfigString) as List<dynamic>,
          );
        }
      });

      return;
    }

    configStructure = initConfigStructure;
  }

  void reconnect() async {
    if (configConnection.isConnected.value) {
      return;
    }

    configConnection.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(configStructure.structure[currentPageIndex].sectionName),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      bottomNavigationBar: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: configConnection.isConnected,
          builder: (context, value, child) {
            if (value == false || configStructure.structure.isEmpty) {
              return Container(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  autofocus: true,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: reconnect,
                  child: Text(
                    "Reconnect",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }

            if (configStructure.structure.length < 2) {
              return SizedBox.shrink();
            }

            return NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
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
                  label: configStructure.structure[index].sectionName,
                ),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: configConnection.isConnected,
          builder: (context, value, child) {
            if (configStructure.structure.isEmpty) {
              return Center(child: Text("No configuration applied"));
            }
            if (value == false) {
              return Center(child: Text("No connection"));
            }
            return DynamicPage(
              title: Text(
                configStructure.structure[currentPageIndex].sectionName,
              ),
              structure: configStructure.structure[currentPageIndex],
            );
          },
        ),
      ),
    );
  }
}
