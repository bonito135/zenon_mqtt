import 'dart:convert';
import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:zenon_mqtt/classes/structure.dart';
import 'package:zenon_mqtt/db/db.dart';

void writeStructureComponentByTagName(
  AppDatabase database,
  StructureComponent widget,
  String? content,
) async {
  if (content == null) {
    return null;
  }

  StructureComponent component = StructureComponent.fromJson(
    jsonDecode(content),
  );

  StructureComponentDBData? entry =
      await (database.select(database.structureComponentDB)..where(
        (t) => t.tagName.equals(widget.tagName ?? ""),
      )).getSingleOrNull();

  if (entry == null) {
    try {
      await database
          .into(database.structureComponentDB)
          .insert(
            StructureComponentDBCompanion.insert(
              type: Value(widget.type),
              tagName: Value(widget.tagName),
              value: Value(component.value),
              description: Value(widget.description),
              unit: Value(widget.unit),
              digits: Value(widget.digits),
              lastUpdateTime: Value(component.lastUpdateTime),
              valid: Value(component.valid),
            ),
          );
    } catch (e) {
      log("Create component error: $e");
      return null;
    }
  } else {
    try {
      await (database.update(database.structureComponentDB)
        ..where((t) => t.id.equals(entry.id))).write(
        StructureComponentDBCompanion(
          id: Value(entry.id),
          type: Value(widget.type),
          tagName: Value(widget.tagName),
          value: Value(component.value),
          description: Value(widget.description),
          unit: Value(widget.unit),
          digits: Value(widget.digits),
          lastUpdateTime: Value(component.lastUpdateTime),
          valid: Value(component.valid),
        ),
      );
    } catch (e) {
      log("Update component error: $e");
      return null;
    }
  }
}

Future<StructureComponent?> readStructureComponentByTagName(
  AppDatabase database,
  String? tagName,
) async {
  if (tagName == null) {
    return null;
  }

  try {
    StructureComponentDBData? entry =
        await (database.select(database.structureComponentDB)
          ..where((t) => t.tagName.equals(tagName))).getSingleOrNull();

    if (entry == null) return null;

    return StructureComponent(
      entry.type,
      entry.tagName,
      entry.value,
      entry.description,
      entry.unit,
      entry.digits,
      entry.lastUpdateTime,
      entry.valid,
    );
  } catch (e) {
    log("Get entry error: $e");
    return null;
  }
}

Future<StructureComponent?> writeAndReturnStructureComponentByTagName(
  AppDatabase database,
  StructureComponent widget,
  String? content,
) async {
  if (content == null) {
    return null;
  }

  StructureComponent component = StructureComponent.fromJson(
    jsonDecode(content),
  );

  StructureComponentDBData? entry =
      await (database.select(database.structureComponentDB)..where(
        (t) => t.tagName.equals(widget.tagName ?? ""),
      )).getSingleOrNull();

  if (entry == null) {
    try {
      await database
          .into(database.structureComponentDB)
          .insert(
            StructureComponentDBCompanion.insert(
              type: Value(widget.type),
              tagName: Value(widget.tagName),
              value: Value(component.value),
              description: Value(widget.description),
              unit: Value(widget.unit),
              digits: Value(widget.digits),
              lastUpdateTime: Value(component.lastUpdateTime),
              valid: Value(component.valid),
            ),
          );
    } catch (e) {
      log("Create component error: $e");
      return null;
    }
  } else {
    try {
      await (database.update(database.structureComponentDB)
        ..where((t) => t.id.equals(entry.id))).write(
        StructureComponentDBCompanion(
          id: Value(entry.id),
          type: Value(widget.type),
          tagName: Value(widget.tagName),
          value: Value(component.value),
          description: Value(widget.description),
          unit: Value(widget.unit),
          digits: Value(widget.digits),
          lastUpdateTime: Value(component.lastUpdateTime),
          valid: Value(component.valid),
        ),
      );
    } catch (e) {
      log("Update component error: $e");
      return null;
    }
  }

  try {
    StructureComponentDBData? updatedEntry =
        await (database.select(database.structureComponentDB)..where(
          (t) => t.tagName.equals(widget.tagName ?? ""),
        )).getSingleOrNull();

    if (updatedEntry == null) {
      return null;
    }
    return StructureComponent(
      updatedEntry.type,
      widget.tagName,
      updatedEntry.value,
      updatedEntry.description,
      updatedEntry.unit,
      updatedEntry.digits,
      updatedEntry.lastUpdateTime,
      updatedEntry.valid,
    );
  } catch (e) {
    log("Get updated entry error: $e");
    return null;
  }
}
