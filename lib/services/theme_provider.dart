import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _lightThemeMode = true;
  bool get lightThemeMode => _lightThemeMode;

  ThemeProvider() {
    _initThemeMode();
  }

  Future setThemeMode(bool lightTheme) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("lightTheme", lightTheme);
    _lightThemeMode = lightTheme;
    notifyListeners();
  }

  Future<bool> getThemeMode() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool("lightTheme") ?? true;
  }

  void _initThemeMode() async {
    _lightThemeMode = await getThemeMode();
    notifyListeners();
  }
}
