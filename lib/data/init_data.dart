import 'package:zenon_mqtt/classes/index.dart';

Component initComponent(index) => Component(
  "text",
  "text/$index",
  "$index",
  "testing",
  "km/h",
  4,
  "2025.03.11T12:14:38",
  true,
);

ConfigStructureItem initConfigStructureItem(index) => ConfigStructureItem(
  "Section $index",
  List<Component>.generate(3, (index) => initComponent(index)),
);

ConfigStructure initConfigStructure = ConfigStructure(
  List<ConfigStructureItem>.generate(
    3,
    (index) => initConfigStructureItem(index),
  ),
);
