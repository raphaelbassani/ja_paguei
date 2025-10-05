import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class LocalStorageConstants {
  static String lang = 'lang';
  static String color = 'color';
  static String theme = 'theme';

  static String light = 'light';
  static String dark = 'dark';

  static final Map<String, MaterialColor> colors = {
    JPLocaleKeys.green: Colors.green,
    JPLocaleKeys.blue: Colors.blue,
    JPLocaleKeys.red: Colors.red,
    JPLocaleKeys.orange: Colors.orange,
    JPLocaleKeys.purple: Colors.purple,
    JPLocaleKeys.pink: Colors.pink,
    JPLocaleKeys.teal: Colors.teal,
    JPLocaleKeys.cyan: Colors.cyan,
    JPLocaleKeys.lime: Colors.lime,
    JPLocaleKeys.indigo: Colors.indigo,
  };

  static final Map<int, String> months = {
    1: JPLocaleKeys.jan,
    2: JPLocaleKeys.feb,
    3: JPLocaleKeys.mar,
    4: JPLocaleKeys.apr,
    5: JPLocaleKeys.may,
    6: JPLocaleKeys.jun,
    7: JPLocaleKeys.jul,
    8: JPLocaleKeys.aug,
    9: JPLocaleKeys.sep,
    10: JPLocaleKeys.oct,
    11: JPLocaleKeys.nov,
    12: JPLocaleKeys.dec,
  };
}
