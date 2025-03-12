import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/chart/bar_chart_sample.dart';
import 'package:zenon_mqtt/components/gauge/linear_gauge.dart';
import 'package:zenon_mqtt/components/gauge/radial_gauge.dart';
import 'package:zenon_mqtt/components/text/timer_text.dart';
import 'package:zenon_mqtt/functions/time.dart';

Widget widgetMap(BuildContext context, Component oldData, Component? newData) {
  Component returnData = Component(
    newData?.type ?? oldData.type,
    newData?.tagName ?? oldData.tagName,
    newData?.value ?? oldData.value,
    newData?.description ?? oldData.description,
    newData?.unit ?? oldData.unit,
    newData?.digits ?? oldData.digits,
    newData?.lastUpdateTime ?? oldData.lastUpdateTime,
  );

  if (returnData.type == "text") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  returnData.description.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
                Text(
                  "${returnData.value.toString().length <= (returnData.digits ?? 0) ? returnData.value.toString() : returnData.value.toString().substring(0, returnData.digits)} ${returnData.unit.toString().replaceAll("@", "")}",
                  style: TextStyle(
                    // fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Poslední změna před:"),
                FutureBuilder(
                  future: Storage(returnData.tagName!).readStorage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TimerText(text: snapshot.data as String);
                    }
                    return Text("No data");
                  },
                ),
              ],
            ),
          ],
        ),
        Divider(),
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
