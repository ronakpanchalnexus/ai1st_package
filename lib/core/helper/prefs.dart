import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();

  factory Prefs() {
    return _instance;
  }

  Prefs._internal();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString({required String key}) {
    return _prefs?.getString(key) ?? '';
  }

  static void setString({required String key, required String value}) {
    _prefs?.setString(key, value);
  }

  static int getInt({required String key}) {
    return _prefs?.getInt(key) ?? 0;
  }

  static void setInt({required String key, required int value}) {
    _prefs?.setInt(key, value);
  }

  static bool getBool({required String key}) {
    return _prefs?.getBool(key) ?? false;
  }

  static void setBool({required String key, required bool value}) {
    _prefs?.setBool(key, value);
  }

  static void clear() {
    _prefs?.clear();
  }
}
