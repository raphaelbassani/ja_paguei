enum BillPaymentMethodEnum {
  creditCard,
  automaticDebit,
  bankSlip,
  pix,
  money;

  const BillPaymentMethodEnum();

  bool get isAutomatic => this == automaticDebit;

  bool get isNotAutomatic => this != automaticDebit;

  static List<String> get paymentMethods =>
      BillPaymentMethodEnum.values.map((e) => e.name).toList();
}
