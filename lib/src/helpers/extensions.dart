import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

extension ContextExtensions on BuildContext {
  get navigator => Navigator.of(this);

  get arguments => ModalRoute.of(this)?.settings.arguments;

  get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  get textStyle => Theme.of(this).textTheme.bodyMedium;

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

  showModal({required Widget child}) {
    showBarModalBottomSheet(
      context: this,
      backgroundColor: backgroundColor,
      builder: (_) => child,
    );
  }
}
