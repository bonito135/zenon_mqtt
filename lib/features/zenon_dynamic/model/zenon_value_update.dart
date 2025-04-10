import 'package:equatable/equatable.dart';

class ZenonValueUpdate extends Equatable {
  const ZenonValueUpdate({
    required this.value,
    required this.lastUpdateTime,
    required this.valid,
  });

  final dynamic value;
  final String lastUpdateTime;
  final bool valid;

  factory ZenonValueUpdate.fromJson(Map<String, dynamic> json) {
    if (json case {
      "value": dynamic value,
      "lastUpdateTime": String lastUpdateTime,
      "valid": bool valid,
    }) {
      return ZenonValueUpdate(
        value: value,
        lastUpdateTime: lastUpdateTime,
        valid: valid,
      );
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

  @override
  List<Object> get props => [lastUpdateTime, valid];

  @override
  bool get stringify => true;
}
