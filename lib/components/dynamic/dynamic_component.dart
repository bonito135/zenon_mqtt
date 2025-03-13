import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/classes/connection.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/widget_map.dart';

class DynamicComponent extends StatefulWidget {
  const DynamicComponent({super.key, required this.component});

  final Component component;

  @override
  State<DynamicComponent> createState() => _DynamicComponentState();
}

class _DynamicComponentState extends State<DynamicComponent> {
  Component? componentData;

  void setComponentData(value) async {
    setState(() {
      componentData = Component.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      );
    });
  }

  late final componentConnection = MQTTConnection(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    widget.component.tagName!,
    MqttConnectMessage().withClientIdentifier(
      'Mqtt_${widget.component.tagName}',
    ),
    // .startClean(), // Non persistent session for testing,
    (String value) => setComponentData(value),
    Storage(widget.component.tagName!),
  );

  void initConnection() async {
    await componentConnection.init();
  }

  @override
  void initState() {
    super.initState();

    initConnection();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: componentConnection.isConnected,
      builder: (context, value, child) {
        if (value == false) {
          return Center(child: Text("No connection"));
        }

        return widgetMap(context, widget.component, componentData);
      },
    );
  }
}
