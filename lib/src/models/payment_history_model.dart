import 'package:equatable/equatable.dart';

import '../enums/bill_payment_method_enum.dart';
import '../helpers/payment_history_database.dart';
import 'bill_model.dart';

class PaymentHistoryModel extends Equatable {
  final int? id;
  final int billId;
  final String name;
  final double value;
  final BillPaymentMethodEnum paymentMethod;
  final int dueDay;
  final bool isVariableValue;
  final DateTime paymentDateTime;

  const PaymentHistoryModel({
    required this.id,
    required this.billId,
    required this.name,
    required this.value,
    required this.paymentMethod,
    required this.dueDay,
    required this.isVariableValue,
    required this.paymentDateTime,
  });

  factory PaymentHistoryModel.fromJson(Map<String, Object?> json) =>
      PaymentHistoryModel(
        id: json[PaymentHistoryFields.id] as int?,
        billId: int.parse(json[PaymentHistoryFields.billId].toString()),
        name: json[PaymentHistoryFields.name].toString(),
        value: double.parse(json[PaymentHistoryFields.value].toString()),
        paymentMethod: BillPaymentMethodEnum.values.byName(
          json[PaymentHistoryFields.paymentMethod].toString(),
        ),
        dueDay: int.parse(json[PaymentHistoryFields.dueDay].toString()),
        isVariableValue:
            json[PaymentHistoryFields.isVariableValue] as String == '1',
        paymentDateTime: DateTime.parse(
          json[PaymentHistoryFields.paymentDateTime].toString(),
        ),
      );

  PaymentHistoryModel fromBillModel(BillModel bill) {
    return PaymentHistoryModel(
      id: null,
      billId: bill.id!,
      name: bill.name,
      value: bill.value,
      paymentDateTime: bill.paymentDateTime!,
      isVariableValue: bill.isVariableValue,
      dueDay: bill.dueDay,
      paymentMethod: bill.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    id,
    billId,
    name,
    value,
    paymentMethod,
    dueDay,
    isVariableValue,
    paymentDateTime,
  ];
}
