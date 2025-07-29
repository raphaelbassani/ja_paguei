import '../enums/bill_payment_method_enum.dart';
import '../enums/bill_status_enum.dart';
import '../helpers/bill_database.dart';
import 'base_model.dart';
import 'payment_history_model.dart';

class BillModel extends BaseModel {
  final BillStatusEnum status;

  const BillModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.paymentMethod,
    required super.dueDay,
    required super.isVariableAmount,
    super.paymentDateTime,
    this.status = BillStatusEnum.pending,
  });

  bool get isPaid => status.isPaid;

  bool get isNotPaid => status.isNotPaid;

  factory BillModel.fromJson(Map<String, Object?> json) => BillModel(
    id: json[BillFields.id] as int?,
    name: json[BillFields.name].toString(),
    amount: double.parse(json[BillFields.amount].toString()),
    paymentMethod: BillPaymentMethodEnum.values.byName(
      json[BillFields.paymentMethod].toString(),
    ),
    status: BillStatusEnum.values.byName(json[BillFields.status].toString()),
    dueDay: int.parse(json[BillFields.dueDay].toString()),
    isVariableAmount: json[BillFields.isVariableAmount] as String == '1',
    paymentDateTime: json[BillFields.paymentDateTime] != null
        ? DateTime.tryParse(json[BillFields.paymentDateTime].toString())
        : null,
  );

  BillModel copyWith({
    int? id,
    String? name,
    double? amount,
    BillPaymentMethodEnum? paymentMethod,
    int? dueDay,
    BillStatusEnum? status,
    bool? isVariableAmount,
    DateTime? paymentDateTime,
  }) => BillModel(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    dueDay: dueDay ?? this.dueDay,
    status: status ?? this.status,
    isVariableAmount: isVariableAmount ?? this.isVariableAmount,
    paymentDateTime: paymentDateTime ?? this.paymentDateTime,
  );

  BillModel copyWithNullId() => BillModel(
    id: null,
    name: name,
    amount: amount,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    status: status,
    isVariableAmount: isVariableAmount,
    paymentDateTime: paymentDateTime,
  );

  BillModel copyWithCleaningPayment() => BillModel(
    id: id,
    name: name,
    amount: amount,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    isVariableAmount: isVariableAmount,
    status: BillStatusEnum.pending,
    paymentDateTime: null,
  );

  Map<String, Object?> toJson() => {
    BillFields.id: id,
    BillFields.name: name,
    BillFields.amount: amount.toStringAsFixed(2),
    BillFields.paymentMethod: paymentMethod.name,
    BillFields.dueDay: dueDay.toString(),
    BillFields.status: status.name,
    BillFields.isVariableAmount: isVariableAmount ? '1' : '0',
    BillFields.paymentDateTime: paymentDateTime?.toIso8601String() ?? '',
  };

  PaymentHistoryModel get toPaymentHistoryModel {
    return PaymentHistoryModel(
      id: null,
      billId: id!,
      name: name,
      amount: amount,
      paymentDateTime: paymentDateTime!,
      isVariableAmount: isVariableAmount,
      dueDay: dueDay,
      paymentMethod: paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    paymentMethod,
    dueDay,
    status,
    isVariableAmount,
    paymentDateTime,
  ];
}
