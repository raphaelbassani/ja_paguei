import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';
import '../enums/bill_status.dart';
import '../helpers/extensions.dart';
import '../helpers/format.dart';
import '../models/bill_model.dart';
import '../view_models/database_view_model.dart';

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
      valueController.text = Format.currencyInput.formatString(
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
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();
    return Scaffold(
      appBar: JPAppBar(title: 'Valor variável', hasLeading: true),
      body: Padding(
        padding: JPPadding.horizontal,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JPSpacingVertical.l,
                  JPSpacingVertical.m,
                  JPText('Qual valor será pago?', type: JPTextTypeEnum.xl),
                  JPSpacingVertical.m,
                  JPSpacingVertical.l,
                  JPTextFormField(
                    controller: valueController,
                    label: 'Valor',
                    hint: bill!.formattedValue,
                    inputFormatters: [Format.currencyInput],
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double value = Format.currencyIntoDouble(text);
                        if (value == 0) {
                          return 'Digite um valor valido';
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
                    primaryButtonLabel: 'Pagar',
                    onTapPrimaryButton: () {
                      BillModel updatedBill = bill!.copyWith(
                        value: Format.currencyIntoDouble(valueController.text),
                        paymentDateTime: DateTime.now(),
                        status: BillStatusEnum.payed,
                      );
                      dataBaseViewModel.updateBill(updatedBill);
                      dataBaseViewModel.createPayment(updatedBill);
                      context.popUntilIsRoot();
                      context.showSnackSuccess('Conta paga!');
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
