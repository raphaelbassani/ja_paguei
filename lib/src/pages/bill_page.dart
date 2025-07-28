import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';
import '../enums/bill_payment_method_enum.dart';
import '../helpers/extensions.dart';
import '../models/bill_model.dart';
import '../view_models/database_view_model.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController dueDayController = TextEditingController();
  BillModel? editBill;
  BillPaymentMethodEnum? paymentMethod;
  bool? isVariableValue;
  bool hasTriedToSendWithPending = false;

  @override
  void initState() {
    super.initState();

    nameController.addListener(_updateListener);
    valueController.addListener(_updateListener);
    dueDayController.addListener(_updateListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      editBill = context.arguments as BillModel?;
      if (isEdition) {
        nameController.text = editBill!.name;
        valueController.text = context.currencyTextInputFormatter.formatString(
          editBill!.value.toStringAsFixed(2),
        );
        dueDayController.text = editBill!.dueDay.toString();
        paymentMethod = editBill!.paymentMethod;
        isVariableValue = editBill!.isVariableValue;
      }
    });
  }

  void _updateListener() {
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    valueController.dispose();
    dueDayController.dispose();
    super.dispose();
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

  bool get hasEditedName =>
      nameController.text.isNotEmpty && nameController.text.length > 2;

  bool get hasEditedValue => valueController.text.isNotEmpty;

  bool get hasEditedDueDay => dueDayController.text.isNotEmpty;

  bool get hasEditedPaymentMethod => paymentMethod != null;

  bool get hasEditedIsVariableValue => isVariableValue != null;

  bool get hasEditedAnyInfo => [
    hasEditedName,
    hasEditedValue,
    hasEditedDueDay,
    hasEditedPaymentMethod,
    hasEditedIsVariableValue,
  ].any((e) => e);

  bool get hasEditedAllInfo => ![
    hasEditedName,
    hasEditedValue,
    hasEditedDueDay,
    hasEditedPaymentMethod,
  ].any((e) => !e);

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .read<DataBaseViewModel>();

    return Scaffold(
      appBar: JPAppBar(title: mainLabel, hasTrailing: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: JPPadding.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!hasEditedName && hasTriedToSendWithPending)
                    _JPTextError('Preencha o nome da conta'),
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
                  if (!hasEditedValue && hasTriedToSendWithPending)
                    _JPTextError('Preencha o valor da conta'),
                  JPTextFormField(
                    controller: valueController,
                    label: 'Valor da conta',
                    hint: '${context.currency} 100,00',
                    inputFormatters: [context.currencyTextInputFormatter],
                    keyboardType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double value = context.currencyIntoDouble(text);
                        if (value == 0) {
                          return 'Digite um valor valido';
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedDueDay && hasTriedToSendWithPending)
                    _JPTextError('Preencha o dia de vencimento'),
                  JPTextFormField(
                    controller: dueDayController,
                    label: 'Dia de vencimento',
                    hint: '01',
                    keyboardType: TextInputType.number,
                    inputFormatters: [context.dueDayInput],
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
                  if (!hasEditedPaymentMethod && hasTriedToSendWithPending)
                    _JPTextError('Preencha o método de pagamento'),
                  JPSelectionTile(
                    title: 'Método de pagamento',
                    info: paymentMethod != null
                        ? context.translate(paymentMethod!.name)
                        : 'Selecione o método de pagamento',
                    onTap: () {
                      context.showModal(
                        child: JPSelectionModal(
                          title: 'Método de pagamento',
                          preSelectedValue: context.translate(
                            paymentMethod?.name,
                          ),
                          items: BillPaymentMethodEnum.paymentMethods,
                          onTapPrimaryButton: (newPaymentMethod) {
                            paymentMethod = BillPaymentMethodEnum.values
                                .firstWhere((e) => e.name == newPaymentMethod);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                  JPSpacingVertical.l,
                  JPSelectionSwitch(
                    label: 'Essa conta tem valor variável?',
                    isSelected: isVariableValue ?? false,
                    onTap: (newVariableValue) {
                      isVariableValue = newVariableValue;
                      setState(() {});
                    },
                  ),
                  if (isEdition) ...[
                    JPSpacingVertical.m,
                    JPSelectionTile(
                      title: 'Não tem mais essa conta?',
                      info: 'Deletar conta',
                      onTap: () {
                        context.showModal(
                          child: JPConfirmationModal(
                            title: 'Deseja deletar essa conta?',
                            primaryButtonLabel: 'Deletar',
                            onTapPrimaryButton: () {
                              dataBaseViewModel.deleteBill(editBill!);
                              context.popUntilIsRoot();
                              context.showSnackInfo(
                                'Conta deletada com sucesso.',
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
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
                  Spacer(),
                  JPActionButtons(
                    primaryButtonLabel: mainLabel,
                    onTapPrimaryButton: () {
                      if (hasEditedAllInfo) {
                        hasTriedToSendWithPending = false;
                        if (isEdition) {
                          BillModel newBillModel = editBill!.copyWith(
                            name: nameController.text,
                            value: context.currencyIntoDouble(
                              valueController.text,
                            ),
                            dueDay: int.parse(dueDayController.text),
                            paymentMethod: paymentMethod,
                            isVariableValue: isVariableValue,
                          );

                          dataBaseViewModel.updateBill(newBillModel);
                          context.showSnackInfo('Conta editada com sucesso.');
                        } else {
                          BillModel newBillModel = BillModel(
                            id: null,
                            name: nameController.text,
                            value: context.currencyIntoDouble(
                              valueController.text,
                            ),
                            dueDay: int.parse(dueDayController.text),
                            paymentMethod: paymentMethod!,
                            isVariableValue: isVariableValue ?? false,
                          );

                          bool hasCreated = dataBaseViewModel.createBill(
                            newBillModel,
                          );
                          if (!hasCreated) {
                            context.showSnackError(
                              'Já existe uma conta com esse nome.',
                            );
                            return;
                          }
                          context.showSnackSuccess('Conta criada com sucesso.');
                        }
                        context.popUntilIsRoot();
                        return;
                      } else {
                        hasTriedToSendWithPending = true;
                        context.showSnackError(
                          'Por favor preencha todos os dados',
                        );
                      }
                      setState(() {});
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

class _JPTextError extends StatelessWidget {
  final String text;

  const _JPTextError(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 12),
            JPSpacingHorizontal.xxs,
            JPText(text, color: Colors.red, type: JPTextTypeEnum.s),
          ],
        ),
        JPSpacingVertical.xs,
      ],
    );
  }
}
