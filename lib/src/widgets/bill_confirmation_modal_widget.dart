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

    BillModel updatedBill = bill.copyWith(
      paymentDateTime: bill.paymentDateTime ?? context.now,
      status: BillStatusEnum.paid,
    );

    return JPConfirmationModal(
      title: context.translate(LocaleKeys.billConfirmationModalTitle),
      primaryButtonLabel: context.translate(
        LocaleKeys.billConfirmationModalPrimaryButtonLabel,
      ),
      secondaryButtonLabel: context.translate(
        LocaleKeys.billConfirmationModalSecondaryButtonLabel,
      ),
      customWidgetBody: hasDateSelection
          ? _CustomWidgetBodyConfirmationModal(updatedBill)
          : null,
      onTapPrimaryButton: () {
        dataBaseViewModel.updateBill(updatedBill);
        dataBaseViewModel.savePaymentIntoHistory(updatedBill);
        context.popUntilIsRoot();
        context.showSnackSuccess(
          context.translate(LocaleKeys.billConfirmationModalSnack),
        );
      },
    );
  }
}

class _CustomWidgetBodyConfirmationModal extends StatelessWidget {
  final BillModel bill;

  const _CustomWidgetBodyConfirmationModal(this.bill);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        JPSpacingVertical.m,
        JPSelectionTile(
          title: context.translate(LocaleKeys.billConfirmationModalDateTitle),
          info: bill.formattedPaymentDate(context),
          onTap: () => context.popOnceAndPushNamed(
            Routes.billPaymentDate,
            arguments: bill,
          ),
        ),
      ],
    );
  }
}
