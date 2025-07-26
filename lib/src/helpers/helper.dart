import '../enums/bill_payment_method_enum.dart';

class Helper {
  static String locale = 'pt_BR';

  static final List<String> paymentMethods = BillPaymentMethodEnum.values
      .map((e) => e.label)
      .toList();
}
