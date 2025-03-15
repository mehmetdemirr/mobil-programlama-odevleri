import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _isFirstOpenKey = 'isFirstOpen';

  static Future<bool> get isFirstOpen async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstOpenKey) ?? true;
  }

  static Future<void> setFirstOpen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstOpenKey, value);
  }
}
