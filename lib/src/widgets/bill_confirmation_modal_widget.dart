import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';
import '../enums/bill_status_enum.dart';
import '../helpers/extensions.dart';
import '../helpers/routes.dart';
import '../models/bill_model.dart';
import '../view_models/database_view_model.dart';

class BillConfirmationModalWidget extends StatelessWidget {
  final BillModel bill;
  final bool hasDateSelection;

  const BillConfirmationModalWidget({
    required this.bill,
    this.hasDateSelection = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    final bool hasAlreadyPaidInThisDate = dataBaseViewModel
        .hasAlreadyPaidBillOnSameDateHistory(bill);

    BillModel updatedBill = bill.copyWith(
      paymentDateTime: bill.paymentDateTime ?? context.now,
      status: BillStatusEnum.paid,
    );

    return JPConfirmationModal(
      title: context.translate(JPLocaleKeys.billConfirmationModalTitle),
      primaryButtonLabel: context.translate(
        JPLocaleKeys.billConfirmationModalPrimaryButtonLabel,
      ),
      secondaryButtonLabel: context.translate(
        JPLocaleKeys.billConfirmationModalSecondaryButtonLabel,
      ),
      customWidgetBody: _CustomWidgetBodyConfirmationModal(
        bill: updatedBill,
        hasDateSelection: hasDateSelection,
        hasAlreadyPaidInThisDate: hasAlreadyPaidInThisDate,
      ),
      onTapPrimaryButton: () {
        dataBaseViewModel.updateBill(updatedBill);
        dataBaseViewModel.savePaymentIntoHistory(updatedBill);
        context.popUntilIsRoot();
        context.showSnackSuccess(
          context.translate(JPLocaleKeys.billConfirmationModalSnack),
        );
      },
    );
  }
}

class _CustomWidgetBodyConfirmationModal extends StatelessWidget {
  final BillModel bill;
  final bool hasDateSelection;
  final bool hasAlreadyPaidInThisDate;

  const _CustomWidgetBodyConfirmationModal({
    required this.bill,
    required this.hasDateSelection,
    required this.hasAlreadyPaidInThisDate,
  });

  @override
  Widget build(BuildContext context) {
    if (hasDateSelection) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JPSpacingVertical.m,
          JPSelectionTile(
            title: context.translate(
              JPLocaleKeys.billConfirmationModalDateTitle,
            ),
            info: bill.formattedPaymentDate(context),
            onTap: () => context.popOnceAndPushNamed(
              Routes.billPaymentDate,
              arguments: bill,
            ),
          ),
          if (hasAlreadyPaidInThisDate) const _HasAlreadyPaidWidget(),
        ],
      );
    }

    if (hasAlreadyPaidInThisDate) {
      return const _HasAlreadyPaidWidget(hasExtraSpacing: true);
    }

    return const SizedBox();
  }
}

class _HasAlreadyPaidWidget extends StatelessWidget {
  final bool hasExtraSpacing;

  const _HasAlreadyPaidWidget({this.hasExtraSpacing = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasExtraSpacing) JPSpacingVertical.s,
        JPSpacingVertical.s,
        JPText(
          context.translate(JPLocaleKeys.billConfirmationModalDateSubtitle),
          type: JPTextTypeEnum.s,
          color: Colors.red,
        ),
      ],
    );
  }
}
