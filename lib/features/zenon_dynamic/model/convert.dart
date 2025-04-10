import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:equatable/equatable.dart';

part "convert.g.dart";

@j.JsonSerializable()
class ConfigStructure extends Equatable {
  @j.JsonKey(name: "structure")
  final List<ConfigStructureItem> structure;

  const ConfigStructure({required this.structure});

  factory ConfigStructure.fromJson(Map<String, dynamic> json) =>
      _$ConfigStructureFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigStructureToJson(this);

  static JsonTypeConverter2<ConfigStructure, Uint8List, Object?>
  binaryConverter = TypeConverter.jsonb(
    fromJson: (json) => ConfigStructure.fromJson(json as Map<String, Object?>),
    toJson: (data) => data.toJson(),
  );

  @override
  List<Object> get props => [structure];

  @override
  bool get stringify => true;
}

@j.JsonSerializable()
class ConfigStructureItem extends Equatable {
  @j.JsonKey(name: "sectionName")
  final String sectionName;
  @j.JsonKey(name: "elements")
  final List<ConfigStructureElement> elements;

  const ConfigStructureItem({
    required this.sectionName,
    required this.elements,
  });

  factory ConfigStructureItem.fromJson(Map<String, dynamic> json) =>
      _$ConfigStructureItemFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigStructureItemToJson(this);

  static JsonTypeConverter2<ConfigStructureItem, Uint8List, Object?>
  binaryConverter = TypeConverter.jsonb(
    fromJson:
        (json) => ConfigStructureItem.fromJson(json as Map<String, Object?>),
    toJson: (data) => data.toJson(),
  );

  @override
  List<Object> get props => [sectionName, elements];

  @override
  bool get stringify => true;
}

@j.JsonSerializable()
class ConfigStructureElement extends Equatable {
  @j.JsonKey(name: "type")
  final String type;
  @j.JsonKey(name: "tagName")
  final String tagName;
  @j.JsonKey(name: "description")
  final String description;
  @j.JsonKey(name: "unit")
  final String unit;
  @j.JsonKey(name: "digits")
  final int digits;
  @j.JsonKey(name: "value")
  final dynamic value;

  const ConfigStructureElement({
    required this.type,
    required this.tagName,
    required this.description,
    required this.unit,
    required this.digits,
    required this.value,
  });

  factory ConfigStructureElement.fromJson(Map<String, dynamic> json) =>
      _$ConfigStructureElementFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigStructureElementToJson(this);

  static JsonTypeConverter2<ConfigStructureElement, Uint8List, Object?>
  binaryConverter = TypeConverter.jsonb(
    fromJson:
        (json) => ConfigStructureElement.fromJson(json as Map<String, Object?>),
    toJson: (data) => data.toJson(),
  );

  @override
  List<Object> get props => [type, tagName, description, unit, digits];

  @override
  bool get stringify => true;
}
