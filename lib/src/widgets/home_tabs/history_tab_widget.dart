import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui.dart';
import '../../models/bill_model.dart';
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
            childCount: dataBaseViewModel.payments.length,
            (_, index) {
              final BillModel bill = dataBaseViewModel.payments[index];
              return Padding(
                padding: JPPadding.horizontal,
                child: Column(
                  children: [
                    if (index != 0) ...[Divider(), JPSpacingVertical.xxs],
                    _ItemWidget(bill),
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
  final BillModel bill;

  const _ItemWidget(this.bill);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JPText(bill.name, type: JPTextTypeEnum.l),
        JPSpacingVertical.xxs,
        Row(
          children: [
            JPText(bill.formattedValue),
            if (bill.isVariableValue) ...[
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
        JPText(bill.labelWithDueDate, hasDefaultOpacity: true),
        JPSpacingVertical.xs,
        JPText(
          bill.labelWithPaymentDate,
          hasDefaultOpacity: true,
          type: JPTextTypeEnum.s,
        ),
        JPSpacingVertical.s,
      ],
    );
  }
}
