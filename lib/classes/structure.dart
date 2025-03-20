class ConfigStructure {
  final List<ConfigStructureItem> structure;

  ConfigStructure(this.structure);

  factory ConfigStructure.fromJson(List<dynamic> json) => ConfigStructure(
    List<ConfigStructureItem>.from(
      json.map((x) => ConfigStructureItem.fromJson(x as Map<String, dynamic>)),
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
          (json["elements"] as List).map(
            (x) => StructureComponent.fromJson(x as Map<String, dynamic>),
          ),
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
  bool? valid;

  StructureComponent(
    this.type,
    this.tagName,
    this.value,
    this.description,
    this.unit,
    this.digits,
    this.lastUpdateTime,
    this.valid,
  );

  factory StructureComponent.fromJson(Map<String, dynamic> json) {
    return StructureComponent(
      json['type'] as String?,
      json["tagName"] as String?,
      json["value"]?.toString(),
      json["description"] as String?,
      json["unit"] as String?,
      json["digits"] as int?,
      json["lastUpdateTime"] as String?,
      json["valid"] as bool?,
    );
  }
}
