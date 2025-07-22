import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension ContextExtensions on BuildContext {
  get navigator => Navigator.of(this);

  get arguments => ModalRoute.of(this)?.settings.arguments;

  get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  get textStyle => Theme.of(this).textTheme.bodyMedium;

  get height => MediaQuery.of(this).size.height;

  get width => MediaQuery.of(this).size.width;

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

  showSnackError(String message) {
    showTopSnackBar(Overlay.of(this), CustomSnackBar.error(message: message));
  }
}
