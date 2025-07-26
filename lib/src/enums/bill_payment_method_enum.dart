enum BillPaymentMethodEnum {
  creditCard(label: 'Cartão de crédito'),
  automaticDebit(label: 'Débito automático'),
  bankSlip(label: 'Boleto'),
  pix(label: 'PIX'),
  money(label: 'Dinheiro');

  const BillPaymentMethodEnum({required this.label});

  final String label;

  bool get isAutomatic => this == automaticDebit;

  bool get isNotAutomatic => this != automaticDebit;
}
