import 'package:equatable/equatable.dart';

import '../enums/bill_payment_method_enum.dart';
import '../enums/bill_status.dart';
import '../helpers/bills_database.dart';
import '../helpers/format.dart';

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

  String get labelWithDueDate => 'Todo dia $formattedDueDay';

  String get formattedDueDay => dueDay.toString().padLeft(2, '0');

  String get formattedValue => Format.currencyIntoString(value);

  factory BillModel.fromJson(Map<String, Object?> json) => BillModel(
    id: json[BillFields.id] as int?,
    name: json[BillFields.name].toString(),
    value: double.parse(json[BillFields.value].toString()),
    paymentMethod: BillPaymentMethodEnum.values.byName(
      json[BillFields.paymentMethod].toString(),
    ),
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
