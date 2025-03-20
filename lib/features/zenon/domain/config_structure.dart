import '_index.dart';

class ConfigStructure {
  final List<ConfigStructureItem> structure;

  ConfigStructure(this.structure);

  factory ConfigStructure.fromJson(List<dynamic> json) {
    if (json case {"structure": List<ConfigStructureItem> structure}) {
      return ConfigStructure(
        List<ConfigStructureItem>.from(
          structure.map(
            (x) => ConfigStructureItem.fromJson(x as Map<String, dynamic>),
          ),
        ),
      );
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }
}
