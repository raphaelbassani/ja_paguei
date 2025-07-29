import 'package:flutter/material.dart';

import '../../ui.dart';
import '../enums/bill_status_enum.dart';
import '../helpers/extensions.dart';
import '../models/bill_model.dart';
import '../widgets/bill_confirmation_modal_widget.dart';

class BillVariableValuePage extends StatefulWidget {
  const BillVariableValuePage({super.key});

  @override
  State<BillVariableValuePage> createState() => _BillVariableValuePageState();
}

class _BillVariableValuePageState extends State<BillVariableValuePage> {
  TextEditingController valueController = TextEditingController();
  BillModel? bill;

  @override
  void initState() {
    super.initState();

    valueController.addListener(_updateListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bill = context.arguments as BillModel;
      valueController.text = context.currencyTextInputFormatter.formatString(
        bill!.value.toStringAsFixed(2),
      );
    });
  }

  void _updateListener() {
    setState(() {});
  }

  @override
  void dispose() {
    valueController.dispose();
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
                    context.translate(LocaleKeys.variableValueTitle),
                    type: JPTextTypeEnum.xl,
                  ),
                  JPSpacingVertical.m,
                  JPSpacingVertical.l,
                  JPTextFormField(
                    controller: valueController,
                    label: context.translate(LocaleKeys.variableValueLabel),
                    hint: bill?.formattedValue(context) ?? '',
                    inputFormatters: [context.currencyTextInputFormatter],
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double value = context.currencyIntoDouble(text);
                        if (value == 0) {
                          return context.translate(
                            LocaleKeys.variableValueValidatorError,
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
                      LocaleKeys.alreadyPaid,
                    ),
                    onTapPrimaryButton: () {
                      BillModel updatedBill = bill!.copyWith(
                        value: context.currencyIntoDouble(valueController.text),
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
