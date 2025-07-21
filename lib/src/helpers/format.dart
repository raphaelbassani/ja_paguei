import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Format {
  static final brl = 'R\$';

  static String currencyIntoString(num amount) {
    final String currency = NumberFormat.currency(
      locale: 'pt_Br',
      decimalDigits: 2,
      symbol: '',
    ).format(amount.abs()).trim();

    return '$brl $currency';
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
}
