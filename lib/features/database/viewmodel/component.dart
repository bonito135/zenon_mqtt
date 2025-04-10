import 'dart:developer';
import 'package:drift/drift.dart';
import 'package:zenon_mqtt/features/database/repository/database.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/zenon_value_update.dart';

// void writeStructureComponentFromZenonValueUpdate(
//   AppDatabase database,
//   StructureComponentTableData widget,
//   ZenonValueUpdate? zenonValueUpdate,
// ) async {
//   if (zenonValueUpdate == null) {
//     return null;
//   }

//   final entry =
//       await (database.select(database.structureComponentTable)
//         ..where((t) => t.tagName.equals(widget.tagName))).getSingleOrNull();

//   if (entry == null) {
//     try {
//       await database
//           .into(database.structureComponentTable)
//           .insert(
//             StructureComponentTableCompanion.insert(
//               type: widget.type,
//               tagName: widget.tagName,
//               description: widget.description,
//               unit: widget.unit,
//               digits: widget.digits,
//               value: Value(zenonValueUpdate.value.toString()),
//               lastUpdateTime: Value(zenonValueUpdate.lastUpdateTime),
//               valid: Value(zenonValueUpdate.valid),
//             ),
//           );
//     } catch (e) {
//       log("Create component error: $e");
//       return null;
//     }
//   } else {
//     try {
//       await (database.update(database.structureComponentTable)
//         ..where((t) => t.id.equals(entry.id))).write(
//         StructureComponentTableCompanion(
//           id: Value(entry.id),
//           type: Value(widget.type),
//           tagName: Value(widget.tagName),
//           description: Value(widget.description),
//           unit: Value(widget.unit),
//           digits: Value(widget.digits),
//           value: Value(zenonValueUpdate.value.toString()),
//           lastUpdateTime: Value(zenonValueUpdate.lastUpdateTime),
//           valid: Value(zenonValueUpdate.valid),
//         ),
//       );
//     } catch (e) {
//       log("Update component error: $e");
//       return null;
//     }
//   }
// }

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
    log("Get entry error: $e");
    return null;
  }
}

// Future<StructureComponentTableData?> writeAndReturnStructureComponent(
//   AppDatabase database,
//   StructureComponentTableData widget,
//   String? content,
// ) async {
//   if (content == null) {
//     return null;
//   }

//   final component = StructureComponentTableData.fromJson(
//     jsonDecode(content) as Map<String, dynamic>,
//   );

//   StructureComponentTableData? entry =
//       await (database.select(database.structureComponentTable)
//         ..where((t) => t.tagName.equals(widget.tagName))).getSingleOrNull();

//   if (entry == null) {
//     try {
//       await database
//           .into(database.structureComponentTable)
//           .insert(
//             StructureComponentTableCompanion.insert(
//               type: widget.type,
//               tagName: widget.tagName,
//               description: widget.description,
//               unit: widget.unit,
//               digits: widget.digits,
//               value: Value(component.value.toString()),
//               lastUpdateTime: Value(component.lastUpdateTime),
//               valid: Value(component.valid),
//             ),
//           );
//     } catch (e) {
//       log("Create component error: $e");
//       return null;
//     }
//   } else {
//     try {
//       await (database.update(database.structureComponentTable)
//         ..where((t) => t.id.equals(entry.id))).write(
//         StructureComponentTableCompanion(
//           id: Value(entry.id),
//           type: Value(widget.type),
//           tagName: Value(widget.tagName),
//           description: Value(widget.description),
//           unit: Value(widget.unit),
//           digits: Value(widget.digits),
//           value: Value(component.value.toString()),
//           lastUpdateTime: Value(component.lastUpdateTime),
//           valid: Value(component.valid),
//         ),
//       );
//     } catch (e) {
//       log("Update component error: $e");
//       return null;
//     }
//   }

//   try {
//     final updatedEntry =
//         await (database.select(database.structureComponentTable)
//           ..where((t) => t.tagName.equals(widget.tagName))).getSingleOrNull();

//     if (updatedEntry == null) {
//       return null;
//     }
//     return StructureComponentTableData(
//       id: updatedEntry.id,
//       type: updatedEntry.type,
//       tagName: widget.tagName,
//       description: updatedEntry.description,
//       unit: updatedEntry.unit,
//       digits: updatedEntry.digits,
//       value: updatedEntry.value,
//       lastUpdateTime: updatedEntry.lastUpdateTime,
//       valid: updatedEntry.valid,
//     );
//   } catch (e) {
//     log("Get updated entry error: $e");
//     return null;
//   }
// }

Future<StructureComponentTableData?>
writeAndReturnStructureComponentFromZenonValueUpdate(
  AppDatabase database,
  StructureComponentTableData widget,
  ZenonValueUpdate? zenonValueUpdate,
) async {
  if (zenonValueUpdate == null) {
    return null;
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
      log("Create component error: $e");
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
      log("Update component error: $e");
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
    log("Get updated entry error: $e");
    return null;
  }
}
