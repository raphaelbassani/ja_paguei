import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui.dart';
import '../../models/payment_history_model.dart';
import '../../view_models/database_view_model.dart';

class PaymentHistoryTabWidget extends StatelessWidget {
  const PaymentHistoryTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: dataBaseViewModel.paymentHistory.length,
            (_, index) {
              final PaymentHistoryModel payment =
                  dataBaseViewModel.paymentHistory[index];
              return Padding(
                padding: JPPadding.horizontal,
                child: Column(
                  children: [
                    if (index != 0) ...[Divider(), JPSpacingVertical.xxs],
                    _ItemWidget(payment),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final PaymentHistoryModel payment;

  const _ItemWidget(this.payment);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JPText(payment.name, type: JPTextTypeEnum.l),
        JPSpacingVertical.xxs,
        Row(
          children: [
            JPText(payment.formattedValue(context)),
            if (payment.isVariableValue) ...[
              JPSpacingHorizontal.xs,
              JPText(
                '(Valor variável)',
                type: JPTextTypeEnum.s,
                hasDefaultOpacity: true,
              ),
            ],
          ],
        ),
        JPSpacingVertical.xxs,
        JPText(payment.labelWithDueDate, hasDefaultOpacity: true),
        JPSpacingVertical.xs,
        JPText(
          payment.labelWithPaymentDate(context),
          hasDefaultOpacity: true,
          type: JPTextTypeEnum.s,
        ),
        JPSpacingVertical.s,
      ],
    );
  }
}
