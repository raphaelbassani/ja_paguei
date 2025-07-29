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
    required super.value,
    required super.paymentMethod,
    required super.dueDay,
    required super.isVariableValue,
    super.paymentDateTime,
    this.status = BillStatusEnum.pending,
  });

  bool get isPaid => status.isPaid;

  bool get isNotPaid => status.isNotPaid;

  factory BillModel.fromJson(Map<String, Object?> json) => BillModel(
    id: json[BillFields.id] as int?,
    name: json[BillFields.name].toString(),
    value: double.parse(json[BillFields.value].toString()),
    paymentMethod: BillPaymentMethodEnum.values.byName(
      json[BillFields.paymentMethod].toString(),
    ),
    status: BillStatusEnum.values.byName(json[BillFields.status].toString()),
    dueDay: int.parse(json[BillFields.dueDay].toString()),
    isVariableValue: json[BillFields.isVariableValue] as String == '1',
    paymentDateTime: json[BillFields.paymentDateTime] != null
        ? DateTime.tryParse(json[BillFields.paymentDateTime].toString())
        : null,
  );

  BillModel copyWith({
    int? id,
    String? name,
    double? value,
    BillPaymentMethodEnum? paymentMethod,
    int? dueDay,
    BillStatusEnum? status,
    bool? isVariableValue,
    DateTime? paymentDateTime,
  }) => BillModel(
    id: id ?? this.id,
    name: name ?? this.name,
    value: value ?? this.value,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    dueDay: dueDay ?? this.dueDay,
    status: status ?? this.status,
    isVariableValue: isVariableValue ?? this.isVariableValue,
    paymentDateTime: paymentDateTime ?? this.paymentDateTime,
  );

  BillModel copyWithNullId() => BillModel(
    id: null,
    name: name,
    value: value,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    status: status,
    isVariableValue: isVariableValue,
    paymentDateTime: paymentDateTime,
  );

  BillModel copyWithCleaningPayment() => BillModel(
    id: id,
    name: name,
    value: value,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    isVariableValue: isVariableValue,
    status: BillStatusEnum.pending,
    paymentDateTime: null,
  );

  Map<String, Object?> toJson() => {
    BillFields.id: id,
    BillFields.name: name,
    BillFields.value: value.toStringAsFixed(2),
    BillFields.paymentMethod: paymentMethod.name,
    BillFields.dueDay: dueDay.toString(),
    BillFields.status: status.name,
    BillFields.isVariableValue: isVariableValue ? '1' : '0',
    BillFields.paymentDateTime: paymentDateTime?.toIso8601String() ?? '',
  };

  PaymentHistoryModel get toPaymentHistoryModel {
    return PaymentHistoryModel(
      id: null,
      billId: id!,
      name: name,
      value: value,
      paymentDateTime: paymentDateTime!,
      isVariableValue: isVariableValue,
      dueDay: dueDay,
      paymentMethod: paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    value,
    paymentMethod,
    dueDay,
    status,
    isVariableValue,
    paymentDateTime,
  ];
}
