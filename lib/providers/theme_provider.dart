import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool? _isDark;

  bool? get isDark => _isDark;

  Future<void> setDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("dark_mode", true);
    _isDark = true;
    notifyListeners();
  }

  Future<void> setLightTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("dark_mode", false);
    _isDark = false;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDark = isDark;
  }

  static Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isDark = prefs.getBool("dark_mode");
    return isDark ?? true;
  }
}
