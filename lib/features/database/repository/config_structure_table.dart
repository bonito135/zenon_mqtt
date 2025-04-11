part of "database.dart";

class ConfigStructureTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BlobColumn get content =>
      blob().map(ConfigStructure.binaryConverter).nullable()();
}
