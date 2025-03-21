import '_index.dart';

class StructureComponent {
  StructureComponent(
    this.type,
    this.tagName,
    this.description,
    this.unit,
    this.digits,
    this.value,
    this.lastUpdateTime,
    this.valid,
  );

  String type;
  TagName tagName;
  String description;
  String unit;
  int digits;
  dynamic value;
  String? lastUpdateTime;
  bool? valid;

  factory StructureComponent.fromJson(Map<String, dynamic> json) {
    if (json case {
      "type": String type,
      "tagName": TagName tagName,
      "description": String description,
      "unit": String unit,
      "digits": int digits,
      "value": dynamic value,
    }) {
      String? lastUpdateTime = json["lastUpdateTime"] as String?;
      bool? valid = json["valid"] as bool?;

      return StructureComponent(
        type,
        tagName,
        description,
        unit,
        digits,
        value,
        lastUpdateTime,
        valid,
      );
    } else {
      if (json["type"] is! String) {
        throw FormatException(
          'Invalid JSON: required "tagName" field of type String in $json',
        );
      }
      if (json["tagName"] is! TagName) {
        throw FormatException(
          'Invalid JSON: required "tagName" field of type TagName/String in $json',
        );
      }
      if (json["description"] is! String) {
        throw FormatException(
          'Invalid JSON: required "description" field of type String in $json',
        );
      }
      if (json["unit"] is! String) {
        throw FormatException(
          'Invalid JSON: required "unit" field of type String in $json',
        );
      }
      if (json["digits"] is! int) {
        throw FormatException(
          'Invalid JSON: required "digits" field of type int in $json',
        );
      }
      throw FormatException('Invalid JSON: $json');
    }
  }
}
