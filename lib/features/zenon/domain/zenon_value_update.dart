import 'package:zenon_mqtt/features/zenon/domain/shared.dart';

class ZenonValueUpdate {
  ZenonValueUpdate(this.value, this.tagName, this.lastUpdateTime);

  dynamic value;
  TagName tagName;
  String lastUpdateTime;

  factory ZenonValueUpdate.fromJson(Map<String, dynamic> json) {
    if (json case {
      "value": dynamic value,
      "tagName": TagName tagName,
      "lastUpdateTime": String lastUpdateTime,
    }) {
      return ZenonValueUpdate(value, tagName, lastUpdateTime);
    } else {
      if (json["tagName"] is! TagName) {
        throw FormatException(
          'Invalid JSON: required "tagName" field of type TagName/String in $json',
        );
      }
      if (json["lastUpdateTime"] is! String) {
        throw FormatException(
          'Invalid JSON: required "lastUpdateTime" field of type String in $json',
        );
      }
      throw FormatException('Invalid JSON: $json');
    }
  }
}
