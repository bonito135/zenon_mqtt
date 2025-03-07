import 'package:flutter/material.dart';
import 'package:zenon_mqtt/classes/index.dart';

Widget widgetMap(Component component) {
  if (component.type == "text") {
    return Text(component.value.toString());
  }

  return Text("Unknown type");
}
