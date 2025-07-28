import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ui.dart';

extension ContextExtensions on BuildContext {
  get navigator => Navigator.of(this);

  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  TextStyle get textStyle => Theme.of(this).textTheme.bodyMedium!;

  Color get textColor => textStyle.color!;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  get unfocus => FocusScope.of(this).requestFocus(FocusNode());

  DateTime get now => DateUtils.dateOnly(DateTime.now());

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

  void popUntilIsRoot() {
    navigator.popUntil(
      (route) =>
          (route.settings.name != null && route.settings.name.endsWith('/')),
    );
  }

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

  Locale get _deviceLocale => Localizations.localeOf(this);

  String get _languageCode => _deviceLocale.languageCode;

  String? get _countryCode => _deviceLocale.countryCode;

  String? get locale =>
      '$_languageCode${_countryCode != null ? '_$_countryCode' : ''}';

  String get currency =>
      LocaleValues.translate(_languageCode, LocaleKeys.currency);

  CurrencyTextInputFormatter get currencyTextInputFormatter =>
      CurrencyTextInputFormatter.currency(
        locale: '${_languageCode}_$_countryCode',
        symbol: currency,
        decimalDigits: 2,
      );

  double currencyIntoDouble(String amount) {
    final String currency = amount
        .replaceAllMapped('.', (match) => '')
        .replaceAllMapped(',', (match) => '.')
        .replaceAllMapped(this.currency, (match) => '')
        .replaceAllMapped(' ', (match) => '');

    return double.parse(currency);
  }

  String currencyIntoString(num amount) {
    return currencyTextInputFormatter.formatString(amount.toStringAsFixed(2));
  }

  CurrencyTextInputFormatter get dueDayInput =>
      CurrencyTextInputFormatter.currency(
        locale: locale,
        symbol: '',
        decimalDigits: 0,
        maxValue: 31,
      );

  String ddMMyyyy(DateTime date, {String slash = '/'}) {
    if (_languageCode == 'pt') {
      return '${date.day.toString().padLeft(2, '0')}'
          '$slash${date.month.toString().padLeft(2, '0')}'
          '$slash${date.year}';
    }

    return '${date.month.toString().padLeft(2, '0')}'
        '$slash${date.day.toString().padLeft(2, '0')}'
        '$slash${date.year}';
  }

  String mmmmYYYY(DateTime date, {String slash = '/'}) {
    return DateFormat.yMMMM(locale).format(date).capitalizeFirstLetter();
  }
}

extension StringExtensions on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
