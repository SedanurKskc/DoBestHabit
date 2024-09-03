import 'package:shared_preferences/shared_preferences.dart';
import 'prefs_keys.dart';
export 'prefs_keys.dart';

class PreferencesManager {
  static late final SharedPreferences _preferences;

  static Future<SharedPreferences> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future<void> reload() async {
    await _preferences.reload();
  }

  static Future<void> setStringVal(PrefsKeys key, String value) async => await _preferences.setString(key.key, value);
  static String? getStringVal(PrefsKeys key) => _preferences.getString(key.key);

  static Future<void> setIntVal(PrefsKeys key, int value) async => await _preferences.setInt(key.key, value);
  static int? getIntVal(PrefsKeys key) => _preferences.getInt(key.key);

  static Future<void> setBoolVal(PrefsKeys key, bool value) async => await _preferences.setBool(key.key, value);
  static bool? getBoolVal(PrefsKeys key) => _preferences.getBool(key.key);

  static Future<void> setDoubleVal(PrefsKeys key, double value) async => await _preferences.setDouble(key.key, value);
  static double? getDoubleVal(PrefsKeys key) => _preferences.getDouble(key.key);

  static Future<void> setListVal(PrefsKeys key, List<String> value) async => await _preferences.setStringList(key.key, value);
  static List<String>? getListVal(PrefsKeys key) => _preferences.getStringList(key.key);
}
