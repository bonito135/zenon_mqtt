import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/chart/bar_chart_sample.dart';
import 'package:zenon_mqtt/components/gauge/linear_gauge.dart';
import 'package:zenon_mqtt/components/gauge/radial_gauge.dart';
import 'package:zenon_mqtt/components/text/timer_text.dart';

Widget widgetMap(
  BuildContext context,
  StructureComponent component,
  MqttConnectionState connectionState,
) {
  if (component.type == "text") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Divider(height: 0),
        if (connectionState == MqttConnectionState.disconnected)
          LinearProgressIndicator(color: Colors.red),
        if (connectionState == MqttConnectionState.connecting)
          LinearProgressIndicator(),
        ExpansionTile(
          shape: LinearBorder.none,
          collapsedShape: LinearBorder.none,
          tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          childrenPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                component.description.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "${component.value.toString().length <= (component.digits ?? 0) ? component.value.toString() : component.value.toString().substring(0, component.digits)} ${component.unit.toString().replaceAll("@", "")}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Poslední změna před:",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TimerText(lastUpdateTime: component.lastUpdateTime!),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  if (component.type == "chart") {
    return LineChartSample11();
  }

  if (component.type == "linear_gauge") {
    return LinearGauge();
  }

  if (component.type == "radial_gauge") {
    return RadialGauge();
  }

  return Text("Unknown type");
}
