import 'dart:convert';
import 'dart:developer';
import 'package:zenon_mqtt/features/zenon/domain/_index.dart';

void writeConfigStructure(AppDatabase database, String content) async {
  await database
      .into(database.configStructureDB)
      .insert(ConfigStructureDBCompanion.insert(content: content));
}

Future<ConfigStructure?> readConfigStructure(AppDatabase database) async {
  try {
    final config = await (database.select(
      database.configStructureDB,
    )).get().then((value) => value.last);

    return ConfigStructure.fromJson(
      jsonDecode(config.content) as List<dynamic>,
    );
  } catch (e) {
    log("Config read error: $e");
    return null;
  }
}

Future<ConfigStructure?> writeAndReturnConfigStructure(
  AppDatabase database,
  String? content,
) async {
  if (content == null) {
    return null;
  }

  log("Content $content");

  try {
    await database.delete(database.configStructureDB).go();
  } catch (e) {
    log("Delete error: $e");
    return null;
  }

  try {
    await database
        .into(database.configStructureDB)
        .insert(ConfigStructureDBCompanion.insert(content: content));
  } catch (e) {
    log("Insert error: $e");
    return null;
  }

  try {
    final config = await (database.select(
      database.configStructureDB,
    )).get().then((value) => value.last);

    log("config $config");

    return ConfigStructure.fromJson(
      jsonDecode(config.content) as List<dynamic>,
    );
  } catch (e) {
    log("Read error: $e");
    return null;
  }
}
