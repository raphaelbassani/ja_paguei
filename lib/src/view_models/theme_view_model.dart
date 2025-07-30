import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/local_storage_const.dart';
import 'view_model.dart';

class ThemeViewModel extends ViewModel {
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  bool get isDarkMode => _currentTheme == ThemeMode.dark;

  bool get isLightMode => _currentTheme == ThemeMode.light;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final String? savedTheme = prefs.getString(LocalStorageConst.theme);

    if (savedTheme != null) {
      _currentTheme = savedTheme == LocalStorageConst.light
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      final Brightness brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      _currentTheme = isDarkMode ? ThemeMode.dark : ThemeMode.light;
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
