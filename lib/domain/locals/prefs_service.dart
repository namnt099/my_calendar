import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_calendar/domain/model/theme/app_theme_model.dart';

class PrefsService {
  static const _PREF_LANGUAGE = 'pref_language';
  static const _PREF_USER_FULL_NAME = 'pref_user_full_name';
  static const _PREF_USER_PHONE_NUMBER = 'pref_user_phone_number';
  static const _PREF_USER_EMAIL = 'pref_user_email';
  static const _PREF_TOKEN = 'pref_token';
  static const _PREF_UID = '_pref_uid';
  static const _PREF_PHOTO = '_pref_photo';
  static const _PREF_IMG = '_pref_image';

  static SharedPreferences? _prefsInstance;

  static const String _PREF_APP_THEME = '_pref_theme';

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method form iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static Future<bool> saveLanguage(String code) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_LANGUAGE, code);
  }

  static String getLanguage() {
    return _prefsInstance?.getString(_PREF_LANGUAGE) ?? 'vi';
  }

  static String getToken() {
    return _prefsInstance?.getString(_PREF_TOKEN) ?? '';
  }

  static String getUId() {
    return _prefsInstance?.getString(_PREF_UID) ?? '';
  }

  static String getFullName() {
    return _prefsInstance?.getString(_PREF_USER_FULL_NAME) ?? '';
  }

  static String getPhoneNumber() {
    return _prefsInstance?.getString(_PREF_USER_PHONE_NUMBER) ?? '';
  }

  static String getEmail() {
    return _prefsInstance?.getString(_PREF_USER_EMAIL) ?? '';
  }

  static Future<bool> saveToken(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_TOKEN, data);
  }

  static String getPhoto() {
    return _prefsInstance?.getString(_PREF_PHOTO) ?? '';
  }

  static String getImage() {
    return _prefsInstance?.getString(_PREF_IMG) ?? '';
  }

  static Future<bool> savePhoto(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_PHOTO, data);
  }

  static Future<bool> saveImage(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_IMG, data);
  }

  static Future<bool> saveFullName(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_USER_FULL_NAME, data);
  }

  static Future<bool> savePhoneNumber(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_USER_PHONE_NUMBER, data);
  }

  static Future<bool> saveEmail(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_USER_EMAIL, data);
  }

  static Future<bool> saveUId(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_UID, data);
  }

  static Future<bool> clear() async {
    final prefs = await _instance;
    return prefs.clear();
  }

  static Future<bool?> setAppTheme(AppThemModel appThemModel) async {
    return _prefsInstance?.setString(
        _PREF_APP_THEME, json.encode(appThemModel.toJson()));
  }

  static AppThemModel getAppTheme() {
    final result = _prefsInstance?.getString(_PREF_APP_THEME);
    if (result == null) {
      return AppThemModel();
    }
    final jsonDecode = json.decode(result) as Map<String, dynamic>;
    return AppThemModel.fromJson(jsonDecode);
  }
}
