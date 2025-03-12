import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
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
      configStructure = ConfigStructure.fromJson(decodedInit);
    });
  }

  late final configConnection = MQTTConnection(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    dotenv.env['MQTT_CONFIG_TOPIC']!,
    MqttConnectMessage()
        .withClientIdentifier('Mqtt_config')
        .startClean(), // Non persistent session for testing
    (String value) => setConfig(value),
    configStorage,
  );

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _getStorageConfigString();

    configConnection.init();

    configConnection.isConnected.addListener(() {
      // print(configConnection.isConnected.value);
      autoReconnect(configConnection.isConnected.value);
    });
  }

  void _getStorageConfigString() async {
    String storageConfigString = await configStorage.readStorage();

    if (storageConfigString != "") {
      setState(() {
        configStructure = ConfigStructure.fromJson(
          jsonDecode(storageConfigString) as List<dynamic>,
        );
      });

      return;
    }

    configStructure = initConfigStructure;
  }

  void reconnect() async {
    print(configConnection.isConnected.value);
    if (configConnection.isConnected.value) {
      return;
    }

    configConnection.connect();
  }

  void autoReconnect(bool isConnected) async {
    print('EXAMPLE::autoReconnect config');
    if (isConnected) return;
    Timer(Duration(seconds: 2), () => configConnection.connect());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(configStructure.structure[currentPageIndex].sectionName),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: configConnection.isConnected,
        builder: (context, value, child) {
          if (value == false || configStructure.structure.isEmpty) {
            return Container(
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                autofocus: true,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
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
                currentPageIndex = index;
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
