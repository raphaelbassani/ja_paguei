import '../enums/bill_payment_method_enum.dart';
import '../helpers/payment_history_database.dart';
import 'base_model.dart';

class PaymentHistoryModel extends BaseModel {
  final int billId;

  const PaymentHistoryModel({
    required this.billId,
    required super.paymentDateTime,
    required super.id,
    required super.name,
    required super.value,
    required super.paymentMethod,
    required super.dueDay,
    required super.isVariableValue,
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
    PaymentHistoryFields.paymentDateTime: paymentDateTime!.toIso8601String(),
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
