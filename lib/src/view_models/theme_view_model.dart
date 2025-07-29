import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/local_storage_const.dart';
import 'view_model.dart';

class ThemeViewModel extends ViewModel {
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final String? savedTheme = prefs.getString(LocalStorageConst.theme);

    if (savedTheme != null) {
      _currentTheme = savedTheme == LocalStorageConst.light
          ? ThemeMode.light
          : ThemeMode.dark;
    }

    safeNotify();
  }

  Future<void> changeToDarkTheme() async {
    _currentTheme = ThemeMode.dark;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConst.theme, LocalStorageConst.dark);
    safeNotify();
  }

  Future<void> changeToLightTheme() async {
    _currentTheme = ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConst.theme, LocalStorageConst.light);
    safeNotify();
  }
}
