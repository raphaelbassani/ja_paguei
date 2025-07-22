import 'package:flutter/material.dart';

import 'view_model.dart';

class ThemeViewModel extends ViewModel {
  ThemeMode currentTheme = ThemeMode.system;

  ThemeViewModel();

  void changeToDarkTheme() {
    currentTheme = ThemeMode.dark;
    safeNotify();
  }

  void changeToLightTheme() {
    currentTheme = ThemeMode.light;
    safeNotify();
  }
}
