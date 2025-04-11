part of 'database.dart';

class StructureComponentTable extends Table {
  TextColumn get type => text()();
  TextColumn get tagName => text()();
  TextColumn get description => text()();
  TextColumn get unit => text()();
  IntColumn get digits => integer()();
  TextColumn get value => text().nullable()();
  TextColumn get lastUpdateTime => text().nullable()();
  BoolColumn get valid => boolean().nullable()();
}
