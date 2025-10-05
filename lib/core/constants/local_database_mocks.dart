import 'dart:math';

import '../../data/models.dart';
import '../../presentation/enums.dart';

List<BillModel> mockLoadBills() {
  final random = Random();
  final values = BillPaymentMethodEnum.values;
  final value = values[random.nextInt(values.length)];

  return List.generate(
    10,
    (i) => BillModel(
      id: i + 1,
      name: 'Conta ${i + 1}',
      amount: 100.0 + i * 10,
      dueDay: (i % 28) + 1,
      status: i % 2 == 0 ? BillStatusEnum.paid : BillStatusEnum.pending,
      createdAt: DateTime.now().subtract(Duration(days: 30 * (i + 1))),
      paymentDateTime: i % 2 == 0
          ? DateTime.now().subtract(Duration(days: 5 * (i + 1)))
          : null,
      paymentMethod: value,
      isVariableAmount: i % 2 == 0,
    ),
  );
}

List<HistoryModel> mockLoadHistory() {
  return List.generate(50, (i) {
    final bill = mockLoadBills()[(i % mockLoadBills().length)];
    return HistoryModel(
      id: i + 1,
      billId: bill.id!,
      name: bill.name,
      amount: bill.amount,
      dueDay: bill.dueDay,
      paymentDateTime: DateTime.now().subtract(Duration(days: i * 3)),
      paymentMethod: bill.paymentMethod,
      isVariableAmount: bill.isVariableAmount,
    );
  });
}
