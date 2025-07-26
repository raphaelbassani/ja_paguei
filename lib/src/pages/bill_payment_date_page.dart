import 'package:flutter/material.dart';

import '../../ui.dart';
import '../enums/bill_status.dart';
import '../helpers/extensions.dart';
import '../models/bill_model.dart';
import '../widgets/bill_confirmation_modal_widget.dart';

class BillPaymentDatePage extends StatefulWidget {
  const BillPaymentDatePage({super.key});

  @override
  State<BillPaymentDatePage> createState() => _BillPaymentDatePageState();
}

class _BillPaymentDatePageState extends State<BillPaymentDatePage> {
  BillModel? bill;
  DateTime? newSelectedDate;

  @override
  Widget build(BuildContext context) {
    bill = context.arguments as BillModel;

    return Scaffold(
      appBar: JPAppBar(title: ' ', hasLeading: true),
      body: Padding(
        padding: JPPadding.horizontal,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JPSpacingVertical.m,
                  JPText(
                    'Em qual data a conta foi paga?',
                    type: JPTextTypeEnum.xl,
                  ),
                  JPSpacingVertical.xs,
                  JPCalendar(
                    initialDate: bill!.paymentDateTime ?? context.now,
                    onChanged: (date) {
                      newSelectedDate = date;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Spacer(),
                  JPSpacingVertical.m,
                  JPActionButtons(
                    primaryButtonLabel: 'Já paguei',
                    onTapPrimaryButton: () {
                      BillModel updatedBill = bill!.copyWith(
                        paymentDateTime: newSelectedDate ?? context.now,
                        status: BillStatusEnum.payed,
                      );

                      context.showModal(
                        child: BillConfirmationModalWidget(
                          bill: updatedBill,
                          hasDateSelection: false,
                        ),
                      );
                    },
                  ),
                  JPSpacingVertical.l,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
