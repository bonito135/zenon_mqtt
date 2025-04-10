import 'dart:developer';
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
    log("Config read error: $e");
    return null;
  }
}

Future<ConfigStructureTableData?> writeAndReturnConfigStructure(
  AppDatabase database,
  ConfigStructure? content,
) async {
  if (content == null) {
    return null;
  }

  log("Content $content");

  try {
    await database.delete(database.configStructureTable).go();
  } catch (e) {
    log("Delete error: $e");
    return null;
  }

  try {
    await database
        .into(database.configStructureTable)
        .insert(ConfigStructureTableCompanion.insert(content: content));
  } catch (e) {
    log("Insert error: $e");
    return null;
  }

  try {
    final config = await (database.select(
      database.configStructureTable,
    )).get().then((value) => value.last);

    log("config $config");

    return config;
  } catch (e) {
    log("Read error: $e");
    return null;
  }
}
