import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../ui/lang/locale_keys.dart';
import '../enums/bill_payment_method_enum.dart';
import '../helpers/extensions.dart';

abstract class BaseModel extends Equatable {
  final int? id;
  final String name;
  final double value;
  final BillPaymentMethodEnum paymentMethod;
  final int dueDay;
  final bool isVariableValue;
  final DateTime? paymentDateTime;

  const BaseModel({
    required this.id,
    required this.name,
    required this.value,
    required this.paymentMethod,
    required this.dueDay,
    required this.isVariableValue,
    this.paymentDateTime,
  });

  String formattedValue(BuildContext context) =>
      context.currencyIntoString(value);

  String labelWithDueDate(BuildContext context) =>
      '${isPaymentMethodAutomatic ? context.translate(LocaleKeys.automaticDebit) : context.translate(LocaleKeys.dueDate)}: '
      '${context.translate(LocaleKeys.onTheDay)} $formattedDueDay';

  String labelWithPaymentDate(BuildContext context) => paymentDateTime != null
      ? '${context.translate(LocaleKeys.paidOn)}: ${formattedPaymentDate(context)}'
      : '';

  String formattedPaymentDate(BuildContext context) =>
      paymentDateTime != null ? context.ddMMyyyy(paymentDateTime!) : '';

  bool get isPaymentMethodAutomatic => paymentMethod.isAutomatic;

  String get formattedDueDay => dueDay.toString().padLeft(2, '0');

  bool get isNotPaymentMethodAutomatic => paymentMethod.isNotAutomatic;
}
