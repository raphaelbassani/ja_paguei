import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions.dart';
import '../../../core/ui.dart';
import '../../../data/models.dart';
import '../../../l10n/l10n.dart';
import '../../view_models.dart';

class HistoryTabWidget extends StatelessWidget {
  const HistoryTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
        if (dataBaseViewModel.history.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: JPPadding.all,
              child: JPText(context.translate(JPLocaleKeys.historyNoData)),
            ),
          ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: dataBaseViewModel.history.length,
            (_, index) {
              final HistoryModel payment = dataBaseViewModel.history[index];
              final bool isFirstOfMonth =
                  index == 0 ||
                  payment.paymentDateTime!.month !=
                      dataBaseViewModel
                          .history[index - 1]
                          .paymentDateTime!
                          .month;

              return Padding(
                padding: JPPadding.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isFirstOfMonth) ...[
                      JPSpacingVertical.s,
                      JPText(
                        context.mmmm(payment.paymentDateTime!),
                        type: JPTextTypeEnum.xxl,
                        hasDefaultOpacity: true,
                      ),
                      JPSpacingVertical.s,
                    ],
                    _ItemWidget(payment),
                    JPSpacingVertical.xs,
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
    final DataBaseViewModel dataBaseViewModel = context
        .read<DataBaseViewModel>();

    return JPGestureDetector(
      onLongPress: () {
        context.showModal(
          child: JPConfirmationModal(
            title: context.translate(JPLocaleKeys.historyDeletePayment),
            primaryButtonLabel: context.translate(JPLocaleKeys.delete),
            onTapPrimaryButton: () {
              dataBaseViewModel.deletePaymentOfHistory(payment);
              context.pop();
            },
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JPText(payment.name, type: JPTextTypeEnum.l),
              JPSpacingVertical.xxs,
              JPText(
                payment.labelWithDueDate(context),
                hasDefaultOpacity: true,
                type: JPTextTypeEnum.s,
              ),
              JPSpacingVertical.xs,
              JPText(
                payment.labelWithPaymentDate(context),
                hasDefaultOpacity: true,
                type: JPTextTypeEnum.s,
              ),
              JPSpacingVertical.s,
            ],
          ),
          const Spacer(),
          Column(
            children: [
              JPSpacingVertical.xxs,
              JPText(payment.formattedAmount(context)),
            ],
          ),
        ],
      ),
    );
  }
}
