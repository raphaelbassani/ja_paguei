import '../enums/bill_payment_method_enum.dart';
import '../helpers/history_database.dart';
import 'base_model.dart';

class HistoryModel extends BaseModel {
  final int billId;

  const HistoryModel({
    required this.billId,
    required super.paymentDateTime,
    required super.id,
    required super.name,
    required super.amount,
    required super.paymentMethod,
    required super.dueDay,
    required super.isVariableAmount,
  });

  factory HistoryModel.fromJson(Map<String, Object?> json) => HistoryModel(
    id: json[HistoryFields.id] as int?,
    billId: int.parse(json[HistoryFields.billId].toString()),
    name: json[HistoryFields.name].toString(),
    amount: double.parse(json[HistoryFields.amount].toString()),
    paymentMethod: BillPaymentMethodEnum.values.byName(
      json[HistoryFields.paymentMethod].toString(),
    ),
    dueDay: int.parse(json[HistoryFields.dueDay].toString()),
    isVariableAmount: json[HistoryFields.isVariableAmount] as String == '1',
    paymentDateTime: DateTime.parse(
      json[HistoryFields.paymentDateTime].toString(),
    ),
  );

  HistoryModel copyWithId({required int id}) => HistoryModel(
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
    HistoryFields.id: id,
    HistoryFields.billId: billId,
    HistoryFields.name: name,
    HistoryFields.amount: amount.toStringAsFixed(2),
    HistoryFields.paymentMethod: paymentMethod.name,
    HistoryFields.dueDay: dueDay.toString(),
    HistoryFields.isVariableAmount: isVariableAmount ? '1' : '0',
    HistoryFields.paymentDateTime: paymentDateTime!.toIso8601String(),
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
