import 'package:flutter/cupertino.dart';

import 'const.dart';

class JPPadding {
  static EdgeInsets all = EdgeInsets.all(JPConst.m);

  static EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: JPConst.m);

  static EdgeInsets vertical = EdgeInsets.symmetric(vertical: JPConst.m);

  static EdgeInsets left = EdgeInsets.fromLTRB(JPConst.m, 0, 0, 0);

  static EdgeInsets top = EdgeInsets.fromLTRB(0, JPConst.m, 0, 0);
  static EdgeInsets right = EdgeInsets.fromLTRB(0, 0, JPConst.m, 0);
  static EdgeInsets bottom = EdgeInsets.fromLTRB(0, 0, 0, JPConst.m);
}
