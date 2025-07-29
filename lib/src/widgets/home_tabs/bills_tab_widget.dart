import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui.dart';
import '../../helpers/extensions.dart';
import '../../helpers/routes.dart';
import '../../models/bill_model.dart';
import '../../view_models/database_view_model.dart';
import '../../view_models/theme_view_model.dart';
import '../bill_confirmation_modal_widget.dart';

class BillsTabWidget extends StatelessWidget {
  const BillsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel themeViewModel = context.watch<ThemeViewModel>();
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: JPPrimaryButton(
            label: 'Trocar tema',
            onTap: () {
              if (themeViewModel.currentTheme == ThemeMode.dark) {
                themeViewModel.changeToLightTheme();
              } else {
                themeViewModel.changeToDarkTheme();
              }
            },
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
                  JPText(bill.formattedValue(context)),
                  if (bill.isVariableValue) ...[
                    JPSpacingHorizontal.xs,
                    JPText(
                      '(${context.translate(LocaleKeys.variableAmount)})',
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
        return context.translate(LocaleKeys.overdueToday);
      }
      if (bill.dueDay == context.now.add(Duration(days: 1)).day) {
        return context.translate(LocaleKeys.overdueTomorrow);
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
          label: context.translate(LocaleKeys.alreadyPaid),
          onTap: () {
            if (bill.isVariableValue) {
              context.pushNamed(Routes.billVariableValue, arguments: bill);
              return;
            }
            context.showModal(child: BillConfirmationModalWidget(bill: bill));
          },
        ),
        JPSecondaryButtonSmall(
          label: context.translate(LocaleKeys.edit),
          onTap: () {
            context.pushNamed(Routes.bill, arguments: bill);
          },
        ),
      ],
    );
  }
}
