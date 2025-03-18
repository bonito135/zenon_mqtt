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
  String? type;
  String? tagName;
  dynamic value;
  String? description;
  String? unit;
  int? digits;
  String? lastUpdateTime;
  bool? isValid;

  Component(
    this.type,
    this.tagName,
    this.value,
    this.description,
    this.unit,
    this.digits,
    this.lastUpdateTime,
    this.isValid,
  );

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      json['type'],
      json["tagName"],
      json["value"],
      json["description"],
      json["unit"],
      json["digits"],
      json["lastUpdateTime"],
      json["isValid"],
    );
  }
}
