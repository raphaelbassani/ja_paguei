import 'package:flutter/cupertino.dart';

import 'constants/jp_constants.dart';

class JPPadding {
  static EdgeInsets all = EdgeInsets.all(JPConstants.m);

  static EdgeInsets horizontal = EdgeInsets.symmetric(
    horizontal: JPConstants.m,
  );

  static EdgeInsets vertical = EdgeInsets.symmetric(vertical: JPConstants.m);

  static EdgeInsets left = EdgeInsets.fromLTRB(JPConstants.m, 0, 0, 0);

  static EdgeInsets top = EdgeInsets.fromLTRB(0, JPConstants.m, 0, 0);
  static EdgeInsets right = EdgeInsets.fromLTRB(0, 0, JPConstants.m, 0);
  static EdgeInsets bottom = EdgeInsets.fromLTRB(0, 0, 0, JPConstants.m);
}
