import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  get navigator => Navigator.of(this);

  get arguments => ModalRoute.of(this)?.settings.arguments;

  pop() {
    navigator.pop();
  }

  pushNamed(String route) {
    navigator.pushNamed(route);
  }

  popUntilIsRoot() {
    navigator.popUntil(
      (route) =>
          (route.settings.name != null && route.settings.name.endsWith('/')),
    );
  }
}
