import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.dart';

class LocaleValues extends AssetLoader {
  const LocaleValues();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static String translate(String languageCode, String key) {
    if (languageCode == 'pt') {
      return pt[key]!;
    }

    return en[key]!;
  }

  static const Map<String, String> en = {
    LocaleKeys.title: 'Hello',
    LocaleKeys.currency: '\$',
  };

  // static const Map<String, dynamic> en = { EXAMPLE
  //   'title': 'Hello',
  //   'msg': 'Hello {} in the {} world ',
  //   'msg_named': '{} are written in the {lang} language',
  //   'clickMe': 'Click me',
  //   'profile': {
  //     'reset_password': {
  //       'label': 'Reset Password',
  //       'username': 'Username',
  //       'password': 'password',
  //     },
  //   },
  //   'clicked': {
  //     'zero': 'You clicked {} times!',
  //     'one': 'You clicked {} time!',
  //     'two': 'You clicked {} times!',
  //     'few': 'You clicked {} times!',
  //     'many': 'You clicked {} times!',
  //     'other': 'You clicked {} times!',
  //   },
  //   'amount': {
  //     'zero': 'Your amount : {} ',
  //     'one': 'Your amount : {} ',
  //     'two': 'Your amount : {} ',
  //     'few': 'Your amount : {} ',
  //     'many': 'Your amount : {} ',
  //     'other': 'Your amount : {} ',
  //   },
  //   'gender': {
  //     'male': 'Hi man ;) ',
  //     'female': 'Hello girl :)',
  //     'with_arg': {'male': 'Hi man ;) {}', 'female': 'Hello girl :) {}'},
  //   },
  //   'reset_locale': 'Reset Language',
  // };

  static const Map<String, String> pt = {
    LocaleKeys.title: 'Hello',
    LocaleKeys.currency: 'R\$',
  };

  static const Map<String, Map<String, String>> mapLocales = {
    'en_US': en,
    'en': en,
    'pt_BR': pt,
    'pt': pt,
  };

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('pt', 'BR'),
  ];
}
