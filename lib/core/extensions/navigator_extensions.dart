import 'package:flutter/material.dart';

extension NavigatorExtensions on BuildContext {
  get navigator => Navigator.of(this);

  void pop() {
    navigator.pop();
  }

  void pushNamed(String route, {Object? arguments}) {
    navigator.pushNamed(route, arguments: arguments);
  }

  void popOnceAndPushNamed(String route, {Object? arguments}) {
    pop();
    navigator.pushNamed(route, arguments: arguments);
  }

  void popUntilIsHome() {
    navigator.popUntil(
      (route) =>
          (route.settings.name != null &&
          route.settings.name.endsWith('/home')),
    );
  }
}
