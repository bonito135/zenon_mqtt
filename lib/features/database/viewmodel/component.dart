import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/zenon_value_update.dart';

Future<StructureComponentTableData?> readStructureComponentByTagName(
  AppDatabase database,
  String? tagName,
) async {
  if (tagName == null) {
    return null;
  }

  try {
    StructureComponentTableData? entry =
        await (database.select(database.structureComponentTable)
          ..where((t) => t.tagName.equals(tagName))).getSingleOrNull();

    if (entry == null) return null;

    return entry;
  } catch (e) {
    if (kDebugMode) {
      print("Get entry error: $e");
    }
    return null;
  }
}

Future<StructureComponentTableData?>
writeAndReturnStructureComponentFromZenonValueUpdate(
  AppDatabase database,
  StructureComponentTableData widget,
  ZenonValueUpdate? zenonValueUpdate,
) async {
  if (zenonValueUpdate == null) {
    return readStructureComponentByTagName(database, widget.tagName);
  }

  final entry =
      await (database.select(database.structureComponentTable)
        ..where((t) => t.tagName.equals(widget.tagName))).getSingleOrNull();

  if (entry == null) {
    try {
      await database
          .into(database.structureComponentTable)
          .insert(
            StructureComponentTableCompanion.insert(
              type: widget.type,
              tagName: widget.tagName,
              description: widget.description,
              unit: widget.unit,
              digits: widget.digits,
              value: Value(zenonValueUpdate.value.toString()),
              lastUpdateTime: Value(zenonValueUpdate.lastUpdateTime),
              valid: Value(zenonValueUpdate.valid),
            ),
          );
    } catch (e) {
      if (kDebugMode) {
        print("Create component error: $e");
      }
      return null;
    }
  } else {
    try {
      await (database.update(database.structureComponentTable)
        ..where((t) => t.tagName.equals(entry.tagName))).write(
        StructureComponentTableCompanion(
          type: Value(widget.type),
          tagName: Value(widget.tagName),
          description: Value(widget.description),
          unit: Value(widget.unit),
          digits: Value(widget.digits),
          value: Value(zenonValueUpdate.value.toString()),
          lastUpdateTime: Value(zenonValueUpdate.lastUpdateTime),
          valid: Value(zenonValueUpdate.valid),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Update component error: $e");
      }
      return null;
    }
  }

  try {
    StructureComponentTableData? updatedEntry =
        await (database.select(database.structureComponentTable)
          ..where((t) => t.tagName.equals(widget.tagName))).getSingleOrNull();

    if (updatedEntry == null) {
      return null;
    }
    return StructureComponentTableData(
      type: updatedEntry.type,
      tagName: widget.tagName,
      description: updatedEntry.description,
      unit: updatedEntry.unit,
      digits: updatedEntry.digits,
      value: updatedEntry.value,
      lastUpdateTime: updatedEntry.lastUpdateTime,
      valid: updatedEntry.valid,
    );
  } catch (e) {
    if (kDebugMode) {
      print("Get updated entry error: $e");
    }
    return null;
  }
}
