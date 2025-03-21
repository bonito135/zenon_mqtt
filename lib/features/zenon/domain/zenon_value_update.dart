class ZenonValueUpdate {
  ZenonValueUpdate(this.value, this.lastUpdateTime, this.valid);

  dynamic value;
  String lastUpdateTime;
  bool valid;

  factory ZenonValueUpdate.fromJson(Map<String, dynamic> json) {
    if (json case {
      "value": dynamic value,
      "lastUpdateTime": String lastUpdateTime,
      "valid": bool valid,
    }) {
      return ZenonValueUpdate(value, lastUpdateTime, valid);
    } else {
      if (json["lastUpdateTime"] is! String) {
        throw FormatException(
          'Invalid JSON: required "lastUpdateTime" field of type String in $json',
        );
      }
      if (json["valid"] is! bool) {
        throw FormatException(
          'Invalid JSON: required "valid" field of type bool in $json',
        );
      }
      throw FormatException('Invalid JSON: $json');
    }
  }
}
