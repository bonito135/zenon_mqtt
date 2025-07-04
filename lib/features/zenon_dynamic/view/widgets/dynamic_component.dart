import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:zenon_mqtt/features/database/viewmodel/component.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/zenon_value_update.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/repository/mqtt_connection_repository.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/widget_map.dart';

class DynamicComponent extends StatefulWidget {
  const DynamicComponent({super.key, required this.element});

  final StructureComponentTableData element;

  @override
  State<DynamicComponent> createState() => _DynamicComponentState();
}

class _DynamicComponentState extends State<DynamicComponent> {
  late final componentConnection = MqttConnectionRepository<ZenonValueUpdate>(
    client: MqttServerClient(
      dotenv.env['MQTT_SERVER_PROVIDER']!,
      'Mqtt_${widget.element.tagName}',
    ),
    topic: widget.element.tagName,
    connMess: MqttConnectMessage().startClean(),
    autoReconnect: true,
    secure: false,
  );

  @override
  void initState() {
    componentConnection.connect();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    componentConnection.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: componentConnection.stateNotifier,
      builder: (context, value, child) {
        final MqttClientConnectionStatus connectionState = value;
        // log("Connection value component: ${connectionState.state}");
        if (connectionState.state == MqttConnectionState.disconnected ||
            connectionState.state == MqttConnectionState.faulted) {
          componentConnection.connect();
        }
        if (connectionState.state == MqttConnectionState.connected) {
          componentConnection.listen();
        }
        return ValueListenableBuilder(
          valueListenable: componentConnection.messageNotifier,
          builder: (context, value, child) {
            return FutureBuilder(
              future:
                  connectionState.state == MqttConnectionState.connected
                      ? writeAndReturnStructureComponentFromZenonValueUpdate(
                        context.watch<AppDatabase>(),
                        widget.element,
                        value,
                      )
                      : readStructureComponentByTagName(
                        context.watch<AppDatabase>(),
                        widget.element.tagName,
                      ),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return widgetMap(context, snapshot.data!, connectionState);
                }

                return widgetMap(context, widget.element, connectionState);
              },
            );
          },
        );
      },
    );
  }
}
