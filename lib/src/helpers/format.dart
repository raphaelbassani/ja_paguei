import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class Format {
  static final brl = 'R\$';

  static String currencyIntoString(num amount) {
    return currencyInput.formatString(amount.toStringAsFixed(2));
  }

  static double currencyIntoDouble(String amount) {
    final String currency = amount
        .replaceAllMapped('.', (match) => '')
        .replaceAllMapped(',', (match) => '.')
        .replaceAllMapped(brl, (match) => '')
        .replaceAllMapped(' ', (match) => '');

    return double.parse(currency);
  }

  static CurrencyTextInputFormatter currencyInput =
      CurrencyTextInputFormatter.currency(
        locale: 'pt_BR',
        symbol: brl,
        decimalDigits: 2,
      );

  static CurrencyTextInputFormatter dueDayInput =
      CurrencyTextInputFormatter.currency(
        locale: 'pt_BR',
        symbol: '',
        decimalDigits: 0,
        maxValue: 31,
      );

  static String ddMMyyyy(DateTime date, {String slash = '/'}) {
    return '${date.day.toString().padLeft(2, '0')}'
        '$slash${date.month.toString().padLeft(2, '0')}'
        '$slash${date.year}';
  }
}
