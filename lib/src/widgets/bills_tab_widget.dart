import 'package:flutter/material.dart';
import 'package:ja_paguei/src/view_models/database_view_model.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';

class BillsTabWidget extends StatelessWidget {
  const BillsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel viewModel = context.watch<DataBaseViewModel>();

    return CustomScrollView(
      slivers: [
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
