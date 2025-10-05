import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions.dart';
import '../../../core/ui.dart';
import '../../../data/models.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.dart';
import '../../view_models.dart';
import '../bill_confirmation_modal_widget.dart';
import '../default_padding_widget.dart';

class BillsTabWidget extends StatelessWidget {
  const BillsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
        const DefaultPaddingWidget(),
        if (dataBaseViewModel.bills.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: JPPadding.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JPText(context.translate(JPLocaleKeys.billsNoData)),
                  JPSpacingVertical.xs,
                  JPPrimaryButtonSmall(
                    label: context.translate(JPLocaleKeys.billsCreateNew),
                    onTap: () => context.pushNamed(Routes.bill),
                  ),
                ],
              ),
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: dataBaseViewModel.bills.length,
            (_, index) {
              final BillModel bill = dataBaseViewModel.bills[index];
              return _ItemWidget(bill);
            },
          ),
        ),
        const DefaultPaddingWidget(),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final BillModel bill;

  const _ItemWidget(this.bill);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: JPPadding.horizontal + JPPadding.bottom,
      child: JPGestureDetector(
        onTap: () => context.pushNamed(Routes.bill, arguments: bill),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: JPPadding.all,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    JPText(bill.name, type: JPTextTypeEnum.l),
                    const Spacer(),
                    JPText(bill.formattedAmount(context)),
                  ],
                ),
                JPSpacingVertical.xs,
                Row(
                  children: [
                    JPText(
                      bill.labelWithDueDate(context),
                      hasDefaultOpacity: true,
                    ),
                    const Spacer(),
                    if (bill.isVariableAmount) ...[
                      JPSpacingHorizontal.xs,
                      JPText(
                        '(${context.translate(JPLocaleKeys.variableAmount)})',
                        type: JPTextTypeEnum.s,
                        hasDefaultOpacity: true,
                      ),
                    ],
                  ],
                ),
                JPSpacingVertical.xs,
                Row(
                  children: [
                    if (bill.isNotPaid)
                      JPPrimaryButtonSmall(
                        label: context.translate(JPLocaleKeys.alreadyPaid),
                        onTap: () {
                          if (bill.isVariableAmount) {
                            context.pushNamed(
                              Routes.billVariableAmount,
                              arguments: bill,
                            );
                            return;
                          }
                          context.showModal(
                            child: BillConfirmationModalWidget(bill: bill),
                          );
                        },
                      ),
                    if (bill.paymentDateTime != null) ...[
                      JPSpacingVertical.xs,
                      JPText(
                        bill.labelWithPaymentDate(context),
                        hasDefaultOpacity: true,
                        type: JPTextTypeEnum.s,
                      ),
                    ],
                    const Spacer(),
                    JPStatus(
                      text: statusLabel(context),
                      status: bill.status.jpStatus,
                    ),
                  ],
                ),
                JPSpacingVertical.s,
                // if (bill.isNotPaid) _Buttons(bill),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String statusLabel(BuildContext context) {
    if (bill.isNotPaid) {
      if (bill.dueDay == context.now.day) {
        return context.translate(JPLocaleKeys.overdueToday);
      }
      if (bill.dueDay == context.now.add(const Duration(days: 1)).day) {
        return context.translate(JPLocaleKeys.overdueTomorrow);
      }
    }
    return context.translate(bill.status.name);
  }
}
