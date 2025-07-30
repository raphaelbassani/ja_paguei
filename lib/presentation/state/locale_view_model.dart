import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/local_storage_constants.dart';
import 'base_view_model.dart';

class LocaleViewModel extends BaseViewModel {
  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  String? get languageCode => _appLocale?.languageCode;

  Future<void> loadLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? lang = prefs.getString(LocalStorageConstants.lang);

    if (lang != null) {
      _appLocale = Locale(lang);
    }
    safeNotify();
  }

  Future<void> changeLang(Locale? newLocale) async {
    if (_appLocale?.languageCode == newLocale?.languageCode ||
        newLocale == null) {
      return;
    }

    _appLocale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.lang, newLocale.languageCode);
    safeNotify();
  }
}
