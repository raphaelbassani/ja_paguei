import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../ui.dart';
import '../../ui/widgets/jp_modal_selection.dart';
import '../../ui/widgets/jp_text_form_field.dart';
import '../helpers/extensions.dart';
import '../helpers/format.dart';
import '../helpers/helper.dart';
import '../models/bill_model.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController valueController = TextEditingController();
  BillModel? editBill;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editBill = context.arguments as BillModel?;
      if (editBill != null) {
        nameController.text = editBill!.name;
        valueController.text = Format.currencyIntoString(editBill!.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(title: 'Criar conta', hasTrailing: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: JPPadding.all,
              child: Column(
                children: [
                  JPTextFormField(
                    controller: nameController,
                    autoFocus: true,
                    label: 'Nome da conta',
                    hint: 'Conta de água',
                    inputAction: TextInputAction.next,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        if (text.length < 3) {
                          return 'Digite um nome valido';
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  JPTextFormField(
                    controller: valueController,
                    autoFocus: true,
                    label: 'Valor da conta',
                    hint: '${Format.brl} 100,00',
                    inputFormatters: [Format.currencyInput],
                    keyboardType: TextInputType.number,
                    inputAction: TextInputAction.done,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double value = Format.currencyIntoDouble(text);
                        if (value == 0) {
                          return 'Digite um nome valor valido';
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  JPSelectionTile(
                    title: 'Dia de vencimento',
                    info: editBill != null
                        ? editBill!.formattedDueDate
                        : 'Selecione o dia dos vencimentos',
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        builder: (_) {
                          return JPModalSelection(
                            title: 'Dia de vencimento',
                            items: Helper.daysOfMonth,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
