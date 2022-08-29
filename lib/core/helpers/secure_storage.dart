import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String apiToken = 'apiToken';
  static const String isFirstTime = 'isFirstTime';
  static const String isLoggedIn = 'isLoggedIn';
  static const String firebaseToken = 'firebaseToken';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String> getCustomString(String key) async => await _secureStorage.read(key: key) ?? '';

  saveCustomString(String key, String data) async {
    await _secureStorage.write(key: key, value: data);
  }

  removeCustomString(String key) async {
    await _secureStorage.delete(key: key);
  }
}
