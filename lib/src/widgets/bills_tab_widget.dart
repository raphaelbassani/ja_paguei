import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';
import '../view_models/database_view_model.dart';
import '../view_models/theme_view_model.dart';

class BillsTabWidget extends StatelessWidget {
  const BillsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel viewModel = context.watch<DataBaseViewModel>();
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
            childCount: viewModel.bills.length,
            (_, index) {
              return _ItemWidget();
            },
          ),
        ),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: JPPadding.horizontal + JPPadding.bottom,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JPText('Name', type: JPTextTypeEnum.l),
              JPText('Value', hasDefaultOpacity: true),
              JPText('Date'),
              JPStatus(text: 'Teste', status: JPStatusEnum.warning),
            ],
          ),
          Spacer(),
          JPSpacingHorizontal.s,
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
