class ConfigStructure {
  final List<ConfigStructureItem> structure;

  ConfigStructure(this.structure);

  factory ConfigStructure.fromJson(List<dynamic> json) => ConfigStructure(
    List<ConfigStructureItem>.from(
      json.map((x) => ConfigStructureItem.fromJson(x)),
    ),
  );
}

class ConfigStructureItem {
  final String sectionName;
  final List<Component> components;

  ConfigStructureItem(this.sectionName, this.components);

  factory ConfigStructureItem.fromJson(Map<String, dynamic> json) =>
      ConfigStructureItem(
        json["sectionName"].toString(),
        List<Component>.from(
          json["elements"].map((x) => Component.fromJson(x)),
        ),
      );
}

class Component {
  final String type;
  final String tagName;
  final dynamic value;

  Component(this.type, this.tagName, this.value);

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      json['type'].toString(),
      json["tagName"].toString(),
      json["value"],
    );
  }
}

var init = [
  {
    "sectionName": "Project TEST3",
    "elements": [
      {"type": "text", "tagName": "TEST3/Test3"},
      {"type": "text", "tagName": "TEST3/Test4"},
      {"type": "text", "tagName": "TEST3/Test5"},
    ],
  },
  {
    "sectionName": "Project TEST4",
    "elements": [
      {"type": "text", "tagName": "TEST4/Test4"},
    ],
  },
  {
    "sectionName": "Project TEST5",
    "elements": [
      {"type": "text", "tagName": "TEST5/Test5"},
    ],
  },
];
