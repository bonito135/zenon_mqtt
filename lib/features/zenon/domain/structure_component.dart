import 'package:zenon_mqtt/features/zenon/domain/shared.dart';

class StructureComponent {
  StructureComponent(
    this.type,
    this.tagName,
    this.value,
    this.description,
    this.unit,
    this.digits,
  );

  String type;
  TagName tagName;
  dynamic value;
  String description;
  String unit;
  int digits;

  factory StructureComponent.fromJson(Map<String, dynamic> json) {
    if (json case {
      "type": String type,
      "tagName": TagName tagName,
      "value": dynamic value,
      "description": String description,
      "unit": String unit,
      "digits": int digits,
    }) {
      return StructureComponent(
        type,
        tagName,
        value,
        description,
        unit,
        digits,
      );
    } else {
      if (json["type"] is! TagName) {
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
