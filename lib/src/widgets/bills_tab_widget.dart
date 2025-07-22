import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';
import '../helpers/extensions.dart';
import '../helpers/routes.dart';
import '../models/bill_model.dart';
import '../view_models/database_view_model.dart';
import '../view_models/theme_view_model.dart';

class BillsTabWidget extends StatelessWidget {
  const BillsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();
    final ThemeViewModel themeViewModel = context.watch<ThemeViewModel>();

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
              JPText(
                'Vencimento: Todo dia ${bill.formattedDueDay}',
                hasDefaultOpacity: true,
              ),
              JPSpacingVertical.xs,
              JPStatus(text: bill.status.label, status: JPStatusEnum.warning),
              JPSpacingVertical.s,
              Row(
                children: [
                  JPPrimaryButtonSmall(label: 'Pagar', onTap: () {}),
                  JPSecondaryButtonSmall(
                    label: 'Editar',
                    onTap: () {
                      context.pushNamed(Routes.bill, arguments: bill);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
