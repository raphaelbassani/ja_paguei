import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension PresentationExtensions on BuildContext {
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  TextStyle get textStyle => Theme.of(this).textTheme.bodyMedium!;

  Color get textColor => textStyle.color!;

  Color get baseColor => Colors.green;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  get unfocus => FocusScope.of(this).requestFocus(FocusNode());

  bool get isIos => Platform.isIOS;

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

  Future<bool> androidStoragePermission({
    required Function noPermissionSnackBar,
    required Permission permission,
  }) async {
    final AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

    if (build.version.sdkInt >= 30) {
      var newPermission = await Permission.manageExternalStorage.request();

      if (newPermission.isGranted) {
        return true;
      }

      if (mounted) {
        noPermissionSnackBar(context: this);
        return false;
      }
    }

    var permissionStatus = await permission.isGranted;

    if (permissionStatus) {
      return true;
    }

    var newPermission = await permission.request();

    if (newPermission.isGranted) {
      return true;
    }

    if (mounted) {
      noPermissionSnackBar(context: this);
    }
    return false;
  }
}
