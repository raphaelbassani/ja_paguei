import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';
import 'extensions.dart';

extension LocaleExtensions on BuildContext {
  Locale get _systemLocale => Localizations.localeOf(this);

  String get languageCode => _systemLocale.languageCode;

  String? get _countryCode => _systemLocale.countryCode;

  bool get _isPtBR => languageCode == JPLocaleKeys.pt;

  String? get jpLocale =>
      '$languageCode${_countryCode != null ? '_$_countryCode' : ''}';

  String translate(String? key) => JPLocale.translate(languageCode, key);

  String get currency => translate(JPLocaleKeys.currency);

  CurrencyTextInputFormatter get currencyTextInputFormatter =>
      CurrencyTextInputFormatter.currency(
        locale: '${languageCode}_$_countryCode',
        symbol: currency,
        decimalDigits: 2,
      );

  double currencyIntoDouble(String amount) {
    String formattedAmount;
    if (_isPtBR) {
      formattedAmount = amount
          .replaceAllMapped('.', (match) => '')
          .replaceAllMapped(',', (match) => '.')
          .replaceAllMapped(currency, (match) => '')
          .replaceAllMapped(' ', (match) => '');
    } else {
      formattedAmount = amount
          .replaceAllMapped(',', (match) => '')
          .replaceAllMapped(currency, (match) => '')
          .replaceAllMapped(' ', (match) => '');
    }

    return double.parse(formattedAmount);
  }

  String currencyIntoString(num amount) {
    return currencyTextInputFormatter.formatString(amount.toStringAsFixed(2));
  }

  CurrencyTextInputFormatter get dueDayInput =>
      CurrencyTextInputFormatter.currency(
        locale: jpLocale,
        symbol: '',
        decimalDigits: 0,
        maxValue: 31,
      );

  String dueDayTrailing(int number) {
    if (_isPtBR) {
      return '';
    }

    if (number == 1) {
      return 'st';
    }
    if (number == 2) {
      return 'nd';
    }
    if (number == 3) {
      return 'rd';
    }

    return 'th';
  }

  String ddMMyyyy(DateTime date, {String slash = '/'}) {
    if (_isPtBR) {
      return '${date.day.toString().padLeft(2, '0')}'
          '$slash${date.month.toString().padLeft(2, '0')}'
          '$slash${date.year}';
    }

    return '${date.month.toString().padLeft(2, '0')}'
        '$slash${date.day.toString().padLeft(2, '0')}'
        '$slash${date.year}';
  }

  String mmmmYYYY(DateTime date) {
    return DateFormat.yMMMM(jpLocale).format(date).capitalizeFirstLetter();
  }

  String mmmm(DateTime date) {
    return DateFormat.MMMM(jpLocale).format(date).capitalizeFirstLetter();
  }
}
