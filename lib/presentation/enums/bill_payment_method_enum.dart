import 'package:flutter/cupertino.dart';

import '../../core/extensions/locale_extensions.dart';

enum BillPaymentMethodEnum {
  creditCard,
  automaticDebit,
  bankSlip,
  pix,
  money;

  const BillPaymentMethodEnum();

  bool get isAutomatic => this == automaticDebit;

  bool get isNotAutomatic => this != automaticDebit;

  static List<String> paymentMethods(BuildContext context) =>
      BillPaymentMethodEnum.values
          .map((e) => context.translate(e.name))
          .toList();
}
