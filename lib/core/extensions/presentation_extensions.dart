import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension PresentationExtensions on BuildContext {
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  TextStyle get textStyle => Theme.of(this).textTheme.bodyMedium!;

  Color get textColor => textStyle.color!;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  get unfocus => FocusScope.of(this).requestFocus(FocusNode());

  void showModal({required Widget child}) {
    showBarModalBottomSheet(
      context: this,
      backgroundColor: backgroundColor,
      builder: (_) => child,
    );
  }

  void showSnackInfo(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.info(message: message, maxLines: 20),
    );
  }

  void showSnackSuccess(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.success(message: message, maxLines: 20),
    );
  }

  void showSnackError(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.error(message: message, maxLines: 20),
    );
  }

  void showLoader() {
    if (mounted) {
      if (!loaderOverlay.visible) {
        loaderOverlay.show();
      }
    }
  }

  void hideLoader() {
    if (mounted) {
      if (loaderOverlay.visible) {
        loaderOverlay.hide();
      }
    }
  }
}
