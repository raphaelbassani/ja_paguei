import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui.dart';
import '../../helpers/extensions.dart';
import '../../models/history_model.dart';
import '../../view_models/database_view_model.dart';

class HistoryTabWidget extends StatelessWidget {
  const HistoryTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: dataBaseViewModel.history.length,
            (_, index) {
              final HistoryModel payment = dataBaseViewModel.history[index];
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
  final HistoryModel payment;

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
            JPText(payment.formattedAmount(context)),
            if (payment.isVariableAmount) ...[
              JPSpacingHorizontal.xs,
              JPText(
                '(${context.translate(JPLocaleKeys.variableAmount)})',
                type: JPTextTypeEnum.s,
                hasDefaultOpacity: true,
              ),
            ],
          ],
        ),
        JPSpacingVertical.xxs,
        JPText(payment.labelWithDueDate(context), hasDefaultOpacity: true),
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
