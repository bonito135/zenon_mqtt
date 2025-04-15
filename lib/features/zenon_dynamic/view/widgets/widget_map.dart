import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/dynamic_boolean.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/view/widgets/dynamic_text.dart';
import 'package:zenon_mqtt/l10n/app_localizations.dart';

Widget widgetMap(
  BuildContext context,
  StructureComponentTableData component,
  MqttConnectionState connectionState,
) {
  if (component.type == "text") {
    return DynamicText(
      context: context,
      component: component,
      connectionState: connectionState,
    );
  }

  if (component.type == "boolean") {
    return DynamicBoolean(
      context: context,
      component: component,
      connectionState: connectionState,
    );
  }

  return Text(
    AppLocalizations.of(context)!.unknown_type,
    style: Theme.of(context).textTheme.bodySmall,
  );
}
