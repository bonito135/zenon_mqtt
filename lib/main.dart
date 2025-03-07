import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/helperFunctions/mqtt/mqtt_server_client.dart';
import 'package:zenon_mqtt/widget_map.dart';

void main() {
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
      home: const MyHomePage(title: 'Zenon MQTT Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  final client = MqttServerClient('iot.coreflux.cloud', '');
  ConfigStructure? configStructure;

  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    super.initState();

    _subscribeToMQTT();
  }

  void _subscribeToMQTT() async {
    print("subscribe to mqtt");
    await mqttServerClient("ZenonMQTTPublisher/groups/guest", (
      String value,
    ) async {
      // print("value: $value");
      var decodedInit = jsonDecode(value) as List<dynamic>;
      if (decodedInit.isEmpty) {
        print("decodedInit is empty");
        return;
      }

      setState(() {
        configStructure = ConfigStructure.fromJson(decodedInit);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: List<Widget>.generate(
          configStructure?.structure.length ?? 0,
          (index) => NavigationDestination(
            icon: Icon(Icons.explore),
            label: configStructure?.structure[index].sectionName ?? "",
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              configStructure?.structure.isEmpty == true
                  ? []
                  : List<Widget>.generate(
                    1,
                    (index) => Column(
                      children: [
                        ...List<Widget>.generate(
                          configStructure!
                              .structure[currentPageIndex]
                              .components
                              .length,
                          (index) => widgetMap(
                            configStructure!
                                .structure[currentPageIndex]
                                .components[index],
                          ),
                        ),
                      ],
                    ),
                  ).toList(),
        ),
      ),
    );
  }
}
