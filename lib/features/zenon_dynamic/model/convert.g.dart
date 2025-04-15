// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigStructure _$ConfigStructureFromJson(Map<String, dynamic> json) =>
    ConfigStructure(
      title: json['title'] as String,
      structure:
          (json['structure'] as List<dynamic>)
              .map(
                (e) => ConfigStructureItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$ConfigStructureToJson(ConfigStructure instance) =>
    <String, dynamic>{'title': instance.title, 'structure': instance.structure};

ConfigStructureItem _$ConfigStructureItemFromJson(Map<String, dynamic> json) =>
    ConfigStructureItem(
      svgPath: json['svgPath'] as String?,
      svgColor: json['svgColor'] as String?,
      sectionName: json['sectionName'] as String,
      elements:
          (json['elements'] as List<dynamic>)
              .map(
                (e) =>
                    ConfigStructureElement.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$ConfigStructureItemToJson(
  ConfigStructureItem instance,
) => <String, dynamic>{
  'svgPath': instance.svgPath,
  'svgColor': instance.svgColor,
  'sectionName': instance.sectionName,
  'elements': instance.elements,
};

ConfigStructureElement _$ConfigStructureElementFromJson(
  Map<String, dynamic> json,
) => ConfigStructureElement(
  type: json['type'] as String,
  tagName: json['tagName'] as String,
  description: json['description'] as String,
  unit: json['unit'] as String,
  digits: (json['digits'] as num).toInt(),
  value: json['value'],
);

Map<String, dynamic> _$ConfigStructureElementToJson(
  ConfigStructureElement instance,
) => <String, dynamic>{
  'type': instance.type,
  'tagName': instance.tagName,
  'description': instance.description,
  'unit': instance.unit,
  'digits': instance.digits,
  'value': instance.value,
};
