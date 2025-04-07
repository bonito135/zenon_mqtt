import 'package:drift/drift.dart';

import '_index.dart';

class ConfigStructure extends Table {
  ConfigStructure(this.structure);
  final List<ConfigStructureItem> structure;

  factory ConfigStructure.fromJson(List<dynamic> json) {
    return ConfigStructure(
      List<ConfigStructureItem>.from(
        json.map(
          (x) => ConfigStructureItem.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
