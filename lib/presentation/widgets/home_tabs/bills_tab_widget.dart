import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/ui/ui.dart';
import '../../../data/models/models.dart';
import '../../../l10n/l10n.dart';
import '../../routes/routes.dart';
import '../../state/view_models.dart';
import '../widgets.dart';

class BillsTabWidget extends StatelessWidget {
  const BillsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: dataBaseViewModel.bills.length,
            (_, index) {
              final BillModel bill = dataBaseViewModel.bills[index];
              return _ItemWidget(bill);
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
    return Padding(
      padding: JPPadding.horizontal + JPPadding.bottom,
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
              JPText(bill.name, type: JPTextTypeEnum.l),
              JPSpacingVertical.xxs,
              Row(
                children: [
                  JPText(bill.formattedAmount(context)),
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
              JPSpacingVertical.xxs,
              JPText(bill.labelWithDueDate(context), hasDefaultOpacity: true),
              JPSpacingVertical.xs,
              if (bill.paymentDateTime != null)
                JPText(
                  bill.labelWithPaymentDate(context),
                  hasDefaultOpacity: true,
                  type: JPTextTypeEnum.s,
                ),
              JPSpacingVertical.xs,
              JPStatus(
                text: statusLabel(context),
                status: bill.status.jpStatus,
              ),
              JPSpacingVertical.s,
              if (bill.isNotPaid) _Buttons(bill),
            ],
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

class _Buttons extends StatelessWidget {
  final BillModel bill;

  const _Buttons(this.bill);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        JPPrimaryButtonSmall(
          label: context.translate(JPLocaleKeys.alreadyPaid),
          onTap: () {
            if (bill.isVariableAmount) {
              context.pushNamed(Routes.billVariableAmount, arguments: bill);
              return;
            }
            context.showModal(child: BillConfirmationModalWidget(bill: bill));
          },
        ),
        JPSecondaryButtonSmall(
          label: context.translate(JPLocaleKeys.edit),
          onTap: () {
            context.pushNamed(Routes.bill, arguments: bill);
          },
        ),
      ],
    );
  }
}
