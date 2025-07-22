import 'package:flutter/material.dart';

import '../../ui.dart';
import '../enums/bill_payment_method_enum.dart';
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
  late final TextEditingController dueDayController = TextEditingController();
  BillModel? editBill;
  BillPaymentMethodEnum? paymentMethod;
  bool? isVariableValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editBill = context.arguments as BillModel?;
      if (isEdition) {
        nameController.text = editBill!.name;
        valueController.text = Format.currencyIntoString(editBill!.value);
        dueDayController.text = editBill!.dueDay.toString();
        paymentMethod = editBill!.paymentMethod;
        isVariableValue = editBill!.isVariableValue;
      }
    });
    super.initState();
  }

  bool get isEdition => editBill != null;

  String get mainLabel => isEdition ? 'Editar conta' : 'Criar conta';

  String get cancelModalTitle =>
      isEdition ? 'Deseja cancelar edição?' : 'Deseja cancelar?';

  String get cancelModalInfo => isEdition
      ? 'Ao confirmar você perderá todas as informações editadas.'
      : 'Ao confirmar você perderá todas as informações criadas.';

  String get cancelModalButtonLabel =>
      isEdition ? 'Continuar edição' : 'Continuar criação';

  bool get hasEditedName => nameController.text.isNotEmpty;

  bool get hasEditedValue => valueController.text.isNotEmpty;

  bool get hasEditedDueDayValue => dueDayController.text.isNotEmpty;

  bool get hasEditedPaymentMethod => paymentMethod != null;

  bool get hasEditedIsVariableValue => isVariableValue != null;

  bool get hasEditedAnyInfo => [
    hasEditedName,
    hasEditedValue,
    hasEditedDueDayValue,
    hasEditedPaymentMethod,
    hasEditedIsVariableValue,
  ].any((e) => e);

  bool get hasEditedAllInfo => ![
    hasEditedName,
    hasEditedValue,
    hasEditedDueDayValue,
    hasEditedPaymentMethod,
  ].any((e) => !e);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(title: mainLabel, hasTrailing: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: JPPadding.all,
              child: Column(
                children: [
                  JPTextFormField(
                    controller: nameController,
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
                    label: 'Valor da conta',
                    hint: '${Format.brl} 100,00',
                    inputFormatters: [Format.currencyInput],
                    keyboardType: TextInputType.number,
                    inputAction: TextInputAction.next,
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
                  JPSpacingVertical.l,
                  JPTextFormField(
                    controller: dueDayController,
                    label: 'Dia de vencimento',
                    hint: '01',
                    keyboardType: TextInputType.number,
                    inputFormatters: [Format.dueDayInput],
                    inputAction: TextInputAction.done,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        int value = int.parse(text);
                        if (value > 31 || (value == 0 && text.length == 2)) {
                          return 'Digite um dia valido';
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  JPSelectionTile(
                    title: 'Método de pagamento',
                    info: paymentMethod != null
                        ? paymentMethod!.label
                        : 'Selecione o método de pagamento',
                    onTap: () {
                      context.showModal(
                        child: JPSelectionModal(
                          title: 'Método de pagamento',
                          items: Helper.paymentMethods,
                          onTapPrimaryButton: (newPaymentMethod) {
                            paymentMethod = BillPaymentMethodEnum.values
                                .firstWhere((e) => e.label == newPaymentMethod);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                  JPSpacingVertical.l,
                  JPSelectionSwitch(
                    label: 'Esta conta tem valor variável?',
                    isSelected: isVariableValue ?? false,
                    onTap: (newVariableValue) {
                      isVariableValue = newVariableValue;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: JPPadding.all,
              child: Column(
                children: [
                  JPActionButtons(
                    primaryButtonLabel: mainLabel,
                    onTapPrimaryButton: () {
                      if (hasEditedAllInfo) {
                      } else {
                        context.showSnackError(
                          'Por favor preencha todos os dados',
                        );
                      }
                    },
                    onTapSecondaryButton: () {
                      if (hasEditedAnyInfo) {
                        context.showModal(
                          child: JPConfirmationModal(
                            title: cancelModalTitle,
                            info: cancelModalInfo,
                            primaryButtonLabel: 'Cancelar',
                            onTapPrimaryButton: context.popUntilIsRoot,
                            secondaryButtonLabel: cancelModalButtonLabel,
                            onTapSecondaryButton: context.pop,
                          ),
                        );
                        return;
                      }
                      context.pop();
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
