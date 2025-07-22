import 'package:equatable/equatable.dart';

import '../enums/bill_payment_method_enum.dart';
import '../enums/bill_status.dart';
import '../helpers/bills_database.dart';

class BillModel extends Equatable {
  final int? id;
  final String name;
  final double value;
  final BillPaymentMethodEnum paymentMethod;
  final int dueDay;
  final BillStatusEnum status;
  final bool isVariableValue;
  final DateTime? paymentDateTime;

  const BillModel({
    required this.id,
    required this.name,
    required this.value,
    required this.paymentMethod,
    required this.dueDay,
    this.status = BillStatusEnum.pending,
    this.isVariableValue = false,
    this.paymentDateTime,
  });

  String get formattedDueDate => 'Todo dia $dueDay';

  factory BillModel.fromJson(Map<String, Object?> json) => BillModel(
    id: json[BillFields.id] as int?,
    name: json[BillFields.name] as String,
    value: double.parse(json[BillFields.value] as String),
    paymentMethod: BillPaymentMethodEnum.values.byName(
      json[BillFields.paymentMethod] as String,
    ),
    dueDay: json[BillFields.dueDay] as int,
    isVariableValue: json[BillFields.isVariableValue] as String == '1',
    paymentDateTime: DateTime.tryParse(
      json[BillFields.paymentDateTime] as String? ?? '',
    ),
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

  Map<String, Object?> toJson() => {
    BillFields.id: id,
    BillFields.name: name,
    BillFields.value: value,
    BillFields.paymentMethod: paymentMethod.name,
    BillFields.dueDay: dueDay.toString(),
    BillFields.status: status.name,
    BillFields.isVariableValue: isVariableValue ? '1' : '0',
    BillFields.paymentDateTime: paymentDateTime?.toIso8601String(),
  };

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
