import 'package:flutter/material.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/chart/bar_chart_sample.dart';
import 'package:zenon_mqtt/components/gauge/linear_gauge.dart';
import 'package:zenon_mqtt/components/gauge/radial_gauge.dart';
import 'package:zenon_mqtt/components/text/timer_text.dart';

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
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    returnData.description.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "${returnData.value.toString().length <= (returnData.digits ?? 0) ? returnData.value.toString() : returnData.value.toString().substring(0, returnData.digits)} ${returnData.unit.toString().replaceAll("@", "")}",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
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
