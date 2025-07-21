import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  get navigator => Navigator.of(this);

  pop() {
    navigator.pop();
  }

  pushNamed(String route) {
    navigator.pushNamed(route);
  }

  popUntilIsRoot() {
    navigator.popUntil((route) => route.isFirst);
  }
}
