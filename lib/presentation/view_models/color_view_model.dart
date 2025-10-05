import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/local_storage_constants.dart';
import 'base_view_model.dart';

class ColorViewModel extends BaseViewModel {
  Color? _appColor;

  Color get appColor => _appColor ?? Colors.green;

  String get appColorKey => LocalStorageConstants.colors.entries
      .firstWhere((entry) => entry.value == appColor)
      .key;

  Future<void> loadColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? color = prefs.getString(LocalStorageConstants.color);

    if (color != null) {
      _appColor = LocalStorageConstants.colors[color];
    }
    safeNotify();
  }

  Future<void> changeColor(String? newColor) async {
    if (newColor == null ||
        LocalStorageConstants.colors[newColor] == appColor) {
      return;
    }

    _appColor = LocalStorageConstants.colors[newColor];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.color, newColor);
    safeNotify();
  }
}
