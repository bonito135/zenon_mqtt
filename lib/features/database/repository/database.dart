import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// import 'package:zenon_mqtt/features/database/model/index.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';

part "database.g.dart";
part "config_structure_table.dart";
part "structure_component_table.dart";

@DriftDatabase(tables: [ConfigStructureTable, StructureComponentTable])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}

// class ConfigStructureTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   BlobColumn get content =>
//       blob().map(ConfigStructure.binaryConverter).nullable()();
// }

// class StructureComponentTable extends Table {
//   TextColumn get type => text()();
//   TextColumn get tagName => text()();
//   TextColumn get description => text()();
//   TextColumn get unit => text()();
//   IntColumn get digits => integer()();
//   TextColumn get value => text().nullable()();
//   TextColumn get lastUpdateTime => text().nullable()();
//   BoolColumn get valid => boolean().nullable()();
// }
