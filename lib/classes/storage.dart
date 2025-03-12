import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final String key;

  Storage(this.key);

  final iOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<String?> readStorage() async {
    String? value = await FlutterSecureStorage().read(key: key);
    print("Dynamic value: $value");
    return value;
  }

  writeStorage(dynamic value) async {
    await FlutterSecureStorage().write(
      key: key,
      value: value,
      iOptions: iOptions,
      aOptions: getAndroidOptions(),
    );
  }
}
