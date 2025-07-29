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
    required super.amount,
    required super.paymentMethod,
    required super.dueDay,
    required super.isVariableAmount,
  });

  factory PaymentHistoryModel.fromJson(Map<String, Object?> json) =>
      PaymentHistoryModel(
        id: json[PaymentHistoryFields.id] as int?,
        billId: int.parse(json[PaymentHistoryFields.billId].toString()),
        name: json[PaymentHistoryFields.name].toString(),
        amount: double.parse(json[PaymentHistoryFields.amount].toString()),
        paymentMethod: BillPaymentMethodEnum.values.byName(
          json[PaymentHistoryFields.paymentMethod].toString(),
        ),
        dueDay: int.parse(json[PaymentHistoryFields.dueDay].toString()),
        isVariableAmount:
            json[PaymentHistoryFields.isVariableAmount] as String == '1',
        paymentDateTime: DateTime.parse(
          json[PaymentHistoryFields.paymentDateTime].toString(),
        ),
      );

  PaymentHistoryModel copyWithId({required int id}) => PaymentHistoryModel(
    id: id,
    billId: billId,
    name: name,
    amount: amount,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    isVariableAmount: isVariableAmount,
    paymentDateTime: paymentDateTime,
  );

  Map<String, Object?> toJson() => {
    PaymentHistoryFields.id: id,
    PaymentHistoryFields.billId: billId,
    PaymentHistoryFields.name: name,
    PaymentHistoryFields.amount: amount.toStringAsFixed(2),
    PaymentHistoryFields.paymentMethod: paymentMethod.name,
    PaymentHistoryFields.dueDay: dueDay.toString(),
    PaymentHistoryFields.isVariableAmount: isVariableAmount ? '1' : '0',
    PaymentHistoryFields.paymentDateTime: paymentDateTime!.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    billId,
    name,
    amount,
    paymentMethod,
    dueDay,
    isVariableAmount,
    paymentDateTime,
  ];
}
