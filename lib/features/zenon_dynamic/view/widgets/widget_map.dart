import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:zenon_mqtt/core/localizations/dynamic_localizations.dart';
import 'package:zenon_mqtt/core/utils/custom_rectangle_clipper.dart';
import 'package:zenon_mqtt/core/view/widgets/timer_text.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

Widget widgetMap(
  BuildContext context,
  StructureComponentTableData component,
  MqttConnectionState connectionState,
) {
  if (component.type == "text") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (connectionState == MqttConnectionState.disconnected)
          const LinearProgressIndicator(color: Colors.red),
        if (connectionState == MqttConnectionState.connecting)
          const LinearProgressIndicator(),
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
                  Text(
                    "${component.value.toString().length <= (component.digits) ? component.value.toString() : component.value.toString().substring(0, component.digits)} ${component.unit.toString().replaceAll("@", "")}",
                    style: Theme.of(context).textTheme.displayLarge,
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
                TimerText(lastUpdateTime: component.lastUpdateTime),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  return Text("Unknown type");
}
