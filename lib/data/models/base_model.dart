import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/extensions.dart';
import '../../l10n/l10n.dart';
import '../../presentation/enums.dart';

abstract class BaseModel extends Equatable {
  final int? id;
  final String name;
  final double amount;
  final BillPaymentMethodEnum paymentMethod;
  final int dueDay;
  final bool isVariableAmount;
  final DateTime? paymentDateTime;

  const BaseModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.paymentMethod,
    required this.dueDay,
    required this.isVariableAmount,
    this.paymentDateTime,
  });

  String formattedAmount(BuildContext context) =>
      context.currencyIntoString(amount);

  String labelWithDueDate(BuildContext context) =>
      '${isPaymentMethodAutomatic ? context.translate(JPLocaleKeys.automaticDebit) : context.translate(JPLocaleKeys.dueDate)}: '
      '${context.translate(JPLocaleKeys.onDay)} $formattedDueDay${context.dueDayTrailing(dueDay)}';

  String labelWithTheDueDate(BuildContext context) =>
      '${isPaymentMethodAutomatic ? context.translate(JPLocaleKeys.automaticDebit) : context.translate(JPLocaleKeys.dueDay)}: '
      '${context.translate(JPLocaleKeys.onEveryDay)} $formattedDueDay${context.dueDayTrailing(dueDay)}';

  String labelWithPaymentDate(BuildContext context) => paymentDateTime != null
      ? '${context.translate(JPLocaleKeys.paidOn)}: ${formattedPaymentDate(context)}'
      : '';

  String formattedPaymentDate(BuildContext context) =>
      paymentDateTime != null ? context.ddMMyyyy(paymentDateTime!) : '';

  bool get isPaymentMethodAutomatic => paymentMethod.isAutomatic;

  String get formattedDueDay => dueDay.toString().padLeft(2, '0');

  bool get isNotPaymentMethodAutomatic => paymentMethod.isNotAutomatic;
}
