import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/core/utils/custom_rectangle_clipper.dart';
import 'package:zenon_mqtt/core/view/widgets/timer_text.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

class DynamicBoolean extends StatelessWidget {
  const DynamicBoolean({
    super.key,
    required this.context,
    required this.component,
    required this.connectionState,
  });

  final BuildContext context;
  final StructureComponentTableData component;
  final MqttClientConnectionStatus? connectionState;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          shape: LinearBorder.none,
          collapsedShape: LinearBorder.none,
          tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DynamicLocalization.translate(component.description),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Stack(
                children: [
                  int.parse(component.value.toString()) == 1
                      ? Icon(
                        Icons.toggle_on_outlined,
                        color: Colors.green,
                        size: 40,
                      )
                      : Icon(
                        Icons.toggle_off_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),
                  component.valid == true
                      ? SizedBox.shrink()
                      : Positioned(
                        right: 0,
                        top: 0,
                        child: ClipPath(
                          clipper: CustomTriangleClipper(),
                          child: SizedBox.square(
                            dimension: 10,
                            child: Container(
                              color: Color.fromARGB(202, 244, 67, 54),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.last_change_before,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    TimerText(lastUpdateTime: component.lastUpdateTime),
                    SizedBox(width: 6),
                    connectionState?.state == MqttConnectionState.connected
                        ? const Icon(Icons.album, color: Colors.green, size: 10)
                        : connectionState?.state ==
                            MqttConnectionState.connecting
                        ? const Icon(Icons.album, color: Colors.blue, size: 10)
                        : const Icon(Icons.album, color: Colors.red, size: 10),
                  ],
                ),
              ],
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
