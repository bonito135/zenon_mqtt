import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/classes/mqtt_connection.dart';
import 'package:zenon_mqtt/components/Indicator/sized_process_indicator.dart';
import 'package:zenon_mqtt/widget_map.dart';

class DynamicComponent extends StatefulWidget {
  const DynamicComponent({super.key, required this.component});

  final Component component;

  @override
  State<DynamicComponent> createState() => _DynamicComponentState();
}

class _DynamicComponentState extends State<DynamicComponent> {
  late final componentConnection = MqttConnection(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    widget.component.tagName!,
    MqttConnectMessage().withClientIdentifier(
      'Mqtt_${widget.component.tagName}',
    ),
    // .startClean(), // Non persistent session for testing,
    Storage(widget.component.tagName!),
  );

  void connectionStartup() async {
    componentConnection.init();
    await componentConnection.connect();
  }

  Future<Component?> getStorageComponent() async {
    String storageComponentString =
        await Storage(widget.component.tagName ?? "").readStorage() ?? "";

    if (storageComponentString == "") {
      return null;
    }

    return Component.fromJson(jsonDecode(storageComponentString));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectionStartup();
    });
  }

  @override
  void dispose() {
    super.dispose();

    componentConnection.client.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: componentConnection.state,
      builder: (context, value, child) {
        if (value == MqttConnectionState.connected) {
          componentConnection.listen();

          return ValueListenableBuilder(
            valueListenable: componentConnection.message,
            builder: (context, value, child) {
              return FutureBuilder(
                future: getStorageComponent(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return widgetMap(context, widget.component, snapshot.data);
                  }

                  return SizedProcessIndicator();
                },
              );
            },
          );
        }
        return SizedProcessIndicator();
      },
    );
  }
}
