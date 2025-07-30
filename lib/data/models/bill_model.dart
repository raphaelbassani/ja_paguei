import '../../presentation/enums/enums.dart';
import '../datasources/datasources.dart';
import 'base_model.dart';
import 'history_model.dart';

class BillModel extends BaseModel {
  final BillStatusEnum status;
  final DateTime? createdAt;

  const BillModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.paymentMethod,
    required super.dueDay,
    required super.isVariableAmount,
    super.paymentDateTime,
    this.status = BillStatusEnum.pending,
    this.createdAt,
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
    createdAt: json[BillFields.createdAt] != null
        ? DateTime.tryParse(json[BillFields.createdAt].toString())
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
    DateTime? createdAt,
  }) => BillModel(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    dueDay: dueDay ?? this.dueDay,
    status: status ?? this.status,
    isVariableAmount: isVariableAmount ?? this.isVariableAmount,
    paymentDateTime: paymentDateTime ?? this.paymentDateTime,
    createdAt: createdAt ?? this.createdAt,
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
    createdAt: createdAt,
  );

  BillModel copyWithCleaningPayment() => BillModel(
    id: id,
    name: name,
    amount: amount,
    paymentMethod: paymentMethod,
    dueDay: dueDay,
    isVariableAmount: isVariableAmount,
    createdAt: createdAt,
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
    BillFields.createdAt: createdAt?.toIso8601String() ?? '',
  };

  HistoryModel get toHistoryModel {
    return HistoryModel(
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
    createdAt,
  ];
}
