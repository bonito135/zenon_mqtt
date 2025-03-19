import 'dart:convert';

import 'package:zenon_mqtt/classes/storage.dart';
import 'package:zenon_mqtt/classes/structure.dart';

Future<StructureComponent?> getStorageComponent(String tagName) async {
  String storageComponentString = await Storage(tagName).readStorage() ?? "";

  if (storageComponentString == "") {
    return null;
  }

  return StructureComponent.fromJson(jsonDecode(storageComponentString));
}
