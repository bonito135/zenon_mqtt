import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/chart/bar_chart_sample.dart';
import 'package:zenon_mqtt/components/gauge/linear_gauge.dart';
import 'package:zenon_mqtt/components/gauge/radial_gauge.dart';
import 'package:zenon_mqtt/components/text/timer_text.dart';

Widget widgetMap(
  BuildContext context,
  StructureComponent oldData,
  StructureComponent? newData,
) {
  StructureComponent returnData = StructureComponent(
    newData?.type ?? oldData.type,
    newData?.tagName ?? oldData.tagName,
    newData?.value ?? oldData.value,
    newData?.description ?? oldData.description,
    newData?.unit ?? oldData.unit,
    newData?.digits ?? oldData.digits,
    newData?.lastUpdateTime ?? oldData.lastUpdateTime,
    newData?.isValid ?? oldData.isValid,
  );

  if (returnData.type == "text") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Divider(),
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
                returnData.description.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              FutureBuilder(
                future: Storage(returnData.tagName!).readStorage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dynamic returnValue =
                        StructureComponent.fromJson(
                          jsonDecode(snapshot.data as String)
                              as Map<String, dynamic>,
                        ).value;

                    if (returnData.value != null) {
                      returnValue = returnData.value.toString();
                    }

                    return Text(
                      "${returnValue.length <= (returnData.digits ?? 0) ? returnValue.toString() : returnValue.substring(0, returnData.digits)} ${returnData.unit.toString().replaceAll("@", "")}",
                      style: Theme.of(context).textTheme.displayLarge,
                    );
                  }
                  return const Text("No data");
                },
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
                FutureBuilder(
                  future: Storage(returnData.tagName!).readStorage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TimerText(text: snapshot.data as String);
                    }
                    return const Text("No data");
                  },
                ),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  if (returnData.type == "chart") {
    return LineChartSample11();
  }

  if (returnData.type == "linear_gauge") {
    return LinearGauge();
  }

  if (returnData.type == "radial_gauge") {
    return RadialGauge();
  }

  return Text("Unknown type");
}
