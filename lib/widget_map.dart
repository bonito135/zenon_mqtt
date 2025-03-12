import 'package:flutter/material.dart';
import 'package:zenon_mqtt/classes/index.dart';
import 'package:zenon_mqtt/components/chart/bar_chart_sample.dart';
import 'package:zenon_mqtt/components/gauge/linear_gauge.dart';
import 'package:zenon_mqtt/components/gauge/radial_gauge.dart';

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

  print("returnDataType: ${returnData.type}");
  print("returnDataTagName: ${returnData.tagName}");
  print("returnDataValue: ${returnData.value}");
  print("returnDataDescription: ${returnData.description}");
  print("returnDataUnit: ${returnData.unit}");
  print("returnDataDigits: ${returnData.digits}");
  print("returnDataLastUpdateTime: ${returnData.lastUpdateTime}");

  if (returnData.type == "text") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
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
