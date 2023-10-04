import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePrefsService {
  static const _SECURE_USER_ACCOUNT_NAME = 'pref_user_name';
  static const _SECURE_PW = 'pref_pw';

  static const storage = FlutterSecureStorage();

  static Future<void> saveUserAccountName(String data) async {
    await storage.write(key: _SECURE_USER_ACCOUNT_NAME, value: data);
  }

  static Future<void> savePW(String data) async {
    await storage.write(key: _SECURE_PW, value: data);
  }

  static Future<String?> getUserAccountName() async {
    return storage.read(key: _SECURE_USER_ACCOUNT_NAME);
  }

  static Future<String?> getPW() async {
    return storage.read(key: _SECURE_PW);
  }
}
