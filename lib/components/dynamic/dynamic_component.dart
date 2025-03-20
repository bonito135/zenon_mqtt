import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/db/db.dart';
import 'package:zenon_mqtt/db/functions/component.dart';
import 'package:zenon_mqtt/widget_map.dart';

class DynamicComponent extends StatefulWidget {
  const DynamicComponent({super.key, required this.component});

  final StructureComponent component;

  @override
  State<DynamicComponent> createState() => _DynamicComponentState();
}

class _DynamicComponentState extends State<DynamicComponent> {
  late final componentConnection = MqttConnection(
    MqttServerClient(dotenv.env['MQTT_SERVER_PROVIDER']!, ''),
    widget.component.tagName!,
    MqttConnectMessage()
        .withClientIdentifier('Mqtt_${widget.component.tagName}')
        .startClean(),
  );

  void connectionStartup() async {
    await componentConnection.connect();
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
      valueListenable: componentConnection.stateNotifier,
      builder: (context, value, child) {
        MqttConnectionState connectionState = value;

        if (value == MqttConnectionState.connected) {
          componentConnection.listen();
        }
        return ValueListenableBuilder(
          valueListenable: componentConnection.messageNotifier,
          builder: (context, value, child) {
            return FutureBuilder(
              future:
                  connectionState == MqttConnectionState.connected
                      ? writeAndReturnStructureComponentByTagName(
                        context.watch<AppDatabase>(),
                        widget.component,
                        value,
                      )
                      : readStructureComponentByTagName(
                        context.watch<AppDatabase>(),
                        widget.component.tagName,
                      ),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return widgetMap(context, snapshot.data!, connectionState);
                }

                return widgetMap(context, widget.component, connectionState);
              },
            );
          },
        );
      },
    );
  }
}
