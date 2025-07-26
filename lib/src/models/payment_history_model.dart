import 'package:equatable/equatable.dart';

import '../enums/bill_payment_method_enum.dart';
import '../helpers/format.dart';
import '../helpers/payment_history_database.dart';

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

  String get formattedValue => Format.currencyIntoString(value);

  bool get isPaymentMethodAutomatic => paymentMethod.isAutomatic;

  String get labelWithDueDate =>
      '${isPaymentMethodAutomatic ? 'Débito automático:' : 'Vencimento:'} '
      'Todo dia $formattedDueDay';

  String get formattedDueDay => dueDay.toString().padLeft(2, '0');

  String get labelWithPaymentDate => 'Paga em: $formattedPaymentDate';

  String get formattedPaymentDate => Format.ddMMyyyy(paymentDateTime);

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

  PaymentHistoryModel copyWithId({required int id}) => PaymentHistoryModel(
    id: id,
    billId: billId,
    name: name,
    value: value,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    isVariableValue: isVariableValue,
    paymentDateTime: paymentDateTime,
  );

  Map<String, Object?> toJson() => {
    PaymentHistoryFields.id: id,
    PaymentHistoryFields.billId: billId,
    PaymentHistoryFields.name: name,
    PaymentHistoryFields.value: value.toStringAsFixed(2),
    PaymentHistoryFields.paymentMethod: paymentMethod.name,
    PaymentHistoryFields.dueDay: dueDay.toString(),
    PaymentHistoryFields.isVariableValue: isVariableValue ? '1' : '0',
    PaymentHistoryFields.paymentDateTime: paymentDateTime.toIso8601String(),
  };

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
