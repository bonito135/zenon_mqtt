import '_index.dart';

class ConfigStructureItem {
  final String sectionName;
  final List<StructureComponent> components;

  ConfigStructureItem(this.sectionName, this.components);

  factory ConfigStructureItem.fromJson(Map<String, dynamic> json) {
    if (json case {
      "sectionName": String sectionName,
      "elements": List<dynamic> elements,
    }) {
      return ConfigStructureItem(
        sectionName,
        List<StructureComponent>.from(
          elements.map(
            (x) => StructureComponent.fromJson(x as Map<String, dynamic>),
          ),
        ),
      );
    } else {
      if (json["sectionName"] is! String) {
        throw FormatException(
          'Invalid JSON: required "sectionName" field of type String in $json',
        );
      }
      if (json["elements"] is! List) {
        throw FormatException(
          'Invalid JSON: required "elements" field of type List in $json',
        );
      }
      throw FormatException('Invalid JSON: $json');
    }
  }
}
