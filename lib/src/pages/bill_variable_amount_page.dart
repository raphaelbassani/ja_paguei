import 'package:flutter/material.dart';

import '../../ui.dart';
import '../enums/bill_status_enum.dart';
import '../helpers/extensions.dart';
import '../models/bill_model.dart';
import '../widgets/bill_confirmation_modal_widget.dart';

class BillVariableAmountPage extends StatefulWidget {
  const BillVariableAmountPage({super.key});

  @override
  State<BillVariableAmountPage> createState() => _BillVariableAmountPageState();
}

class _BillVariableAmountPageState extends State<BillVariableAmountPage> {
  TextEditingController amountController = TextEditingController();
  BillModel? bill;

  @override
  void initState() {
    super.initState();

    amountController.addListener(_updateListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bill = context.arguments as BillModel;
      amountController.text = context.currencyTextInputFormatter.formatString(
        bill!.amount.toStringAsFixed(2),
      );
    });
  }

  void _updateListener() {
    setState(() {});
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    context.translate(JPLocaleKeys.variableAmountTitle),
                    type: JPTextTypeEnum.xl,
                  ),
                  JPSpacingVertical.m,
                  JPSpacingVertical.l,
                  JPTextFormField(
                    controller: amountController,
                    label: context.translate(JPLocaleKeys.variableAmountLabel),
                    hint: bill?.formattedAmount(context) ?? '',
                    inputFormatters: [context.currencyTextInputFormatter],
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double amount = context.currencyIntoDouble(text);
                        if (amount == 0) {
                          return context.translate(
                            JPLocaleKeys.variableAmountValidatorError,
                          );
                        }
                      }

                      return null;
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
                  JPActionButtons(
                    primaryButtonLabel: context.translate(
                      JPLocaleKeys.alreadyPaid,
                    ),
                    onTapPrimaryButton: () {
                      BillModel updatedBill = bill!.copyWith(
                        amount: context.currencyIntoDouble(
                          amountController.text,
                        ),
                        paymentDateTime: context.now,
                        status: BillStatusEnum.paid,
                      );

                      context.showModal(
                        child: BillConfirmationModalWidget(bill: updatedBill),
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
