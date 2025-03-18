import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  Storage(this.key);

  final String key;
  ValueNotifier<String?> valueNotifier = ValueNotifier<String?>(null);

  final iOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: false);

  Future<String?> readStorage() async {
    String? value = await FlutterSecureStorage().read(key: key);
    return value;
  }

  Future<String?> writeStorage(dynamic value) async {
    try {
      await FlutterSecureStorage().write(
        key: key,
        value: value,
        iOptions: iOptions,
        aOptions: getAndroidOptions(),
      );

      return value;
    } catch (e) {
      return null;
    }
  }
}
