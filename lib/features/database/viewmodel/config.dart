import 'dart:developer';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';

void writeConfigStructure(
  AppDatabase database,
  ConfigStructureTableData data,
) async {
  await database.into(database.configStructureTable).insert(data);
}

Future<ConfigStructureTableData?> readConfigStructure(
  AppDatabase database,
) async {
  try {
    final config = await (database.select(
      database.configStructureTable,
    )).get().then((value) => value.last);

    return config;
  } catch (e) {
    if (kDebugMode) {
      print("Config read error: $e");
    }
    return null;
  }
}

Future<ConfigStructureTableData?> writeAndReturnConfigStructure(
  AppDatabase database,
  ConfigStructure? content,
) async {
  if (content == null) {
    return readConfigStructure(database);
  }

  try {
    await database.delete(database.configStructureTable).go();
  } catch (e) {
    if (kDebugMode) {
      print("Delete error: $e");
    }
  }

  try {
    await database
        .into(database.configStructureTable)
        .insert(ConfigStructureTableCompanion.insert(content: Value(content)));
  } catch (e) {
    if (kDebugMode) {
      print("Insert error: $e");
    }
    return null;
  }

  try {
    final config = await (database.select(
      database.configStructureTable,
    )).get().then((value) => value.last);

    return config;
  } catch (e) {
    if (kDebugMode) {
      print("Read error: $e");
    }
    return null;
  }
}
