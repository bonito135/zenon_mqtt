import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

part "database.g.dart";

class ConfigStructureDB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  DateTimeColumn get lastUpdate => dateTime().nullable()();
}

class StructureComponentDB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get tagName => text()();
  TextColumn get description => text()();
  TextColumn get unit => text()();
  IntColumn get digits => integer()();
  TextColumn get value => text().nullable()();
  TextColumn get lastUpdateTime => text().nullable()();
  BoolColumn get valid => boolean().nullable()();
}

@DriftDatabase(tables: [ConfigStructureDB, StructureComponentDB])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
