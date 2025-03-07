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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final client = MqttServerClient('iot.coreflux.cloud', '');
  ConfigStructure? configStructure;

  @override
  void initState() {
    super.initState();

    // Or call your function here
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              configStructure?.structure.isEmpty == true
                  ? []
                  : List<Widget>.generate(
                    configStructure?.structure.length ?? 0,
                    (index) => Column(
                      children: [
                        Text(
                          configStructure!.structure[index].sectionName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        ...List<Widget>.generate(
                          configStructure!.structure[0].components.length,
                          (index) => widgetMap(
                            configStructure!.structure[0].components[index],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ).toList(),
        ),
      ),
    );
  }
}
