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
  final List<StructureComponent> components;

  ConfigStructureItem(this.sectionName, this.components);

  factory ConfigStructureItem.fromJson(Map<String, dynamic> json) =>
      ConfigStructureItem(
        json["sectionName"].toString(),
        List<StructureComponent>.from(
          json["elements"].map((x) => StructureComponent.fromJson(x)),
        ),
      );
}

class StructureComponent {
  String? type;
  String? tagName;
  String? value;
  String? description;
  String? unit;
  int? digits;
  String? lastUpdateTime;
  bool? isValid;

  StructureComponent(
    this.type,
    this.tagName,
    this.value,
    this.description,
    this.unit,
    this.digits,
    this.lastUpdateTime,
    this.isValid,
  );

  factory StructureComponent.fromJson(Map<String, dynamic> json) {
    return StructureComponent(
      json['type'],
      json["tagName"],
      json["value"]?.toString(),
      json["description"],
      json["unit"],
      json["digits"],
      json["lastUpdateTime"],
      json["isValid"],
    );
  }
}
