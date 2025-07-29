import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/local_storage_const.dart';
import 'view_model.dart';

class LocaleViewModel extends ViewModel {
  Locale _appLocale = const Locale('en');
  bool _hasSavedLang = false;

  Locale get appLocale => _appLocale;

  Future<void> loadLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? lang = prefs.getString(LocalStorageConst.lang);

    if (lang != null) {
      _hasSavedLang = true;
      _appLocale = Locale(lang);
    }
    safeNotify();
  }

  Future<void> changeLang(Locale newLocale, {bool isFromMain = false}) async {
    if (_appLocale == newLocale || (isFromMain && _hasSavedLang)) {
      return;
    }

    _appLocale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConst.lang, newLocale.languageCode);
    safeNotify();
  }
}
