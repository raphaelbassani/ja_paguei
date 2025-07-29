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
  TextEditingController amountController = TextEditingController();
  TextEditingController dueDayController = TextEditingController();
  BillModel? editBill;
  BillPaymentMethodEnum? paymentMethod;
  bool? isVariableAmount;
  bool hasTriedToSendWithPending = false;

  @override
  void initState() {
    super.initState();

    nameController.addListener(_updateListener);
    amountController.addListener(_updateListener);
    dueDayController.addListener(_updateListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      editBill = context.arguments as BillModel?;
      if (isEdition) {
        nameController.text = editBill!.name;
        amountController.text = context.currencyTextInputFormatter.formatString(
          editBill!.amount.toStringAsFixed(2),
        );
        dueDayController.text = editBill!.dueDay.toString();
        paymentMethod = editBill!.paymentMethod;
        isVariableAmount = editBill!.isVariableAmount;
      }
    });
  }

  void _updateListener() {
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    dueDayController.dispose();
    super.dispose();
  }

  bool get isEdition => editBill != null;

  String get mainLabel => isEdition
      ? context.translate(JPLocaleKeys.editBill)
      : context.translate(JPLocaleKeys.createBill);

  String get cancelModalTitle => isEdition
      ? context.translate(JPLocaleKeys.cancelEditBill)
      : context.translate(JPLocaleKeys.cancelCreateBill);

  String get cancelModalInfo => isEdition
      ? context.translate(JPLocaleKeys.cancelEditBillModalInfo)
      : context.translate(JPLocaleKeys.cancelCreateBillModalInfo);

  String get cancelModalButtonLabel => isEdition
      ? context.translate(JPLocaleKeys.cancelEditBillModalButtonLabel)
      : context.translate(JPLocaleKeys.cancelCreateBillModalButtonLabel);

  bool get hasEditedName =>
      nameController.text.isNotEmpty && nameController.text.length > 2;

  bool get hasEditedAmount => amountController.text.isNotEmpty;

  bool get hasEditedDueDay => dueDayController.text.isNotEmpty;

  bool get hasEditedPaymentMethod => paymentMethod != null;

  bool get hasEditedIsVariableAmount => isVariableAmount != null;

  bool get hasEditedAnyInfo => [
    hasEditedName,
    hasEditedAmount,
    hasEditedDueDay,
    hasEditedPaymentMethod,
    hasEditedIsVariableAmount,
  ].any((e) => e);

  bool get hasEditedAllInfo => ![
    hasEditedName,
    hasEditedAmount,
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
                    _JPTextError(context.translate(JPLocaleKeys.billNameError)),
                  JPTextFormField(
                    controller: nameController,
                    label: context.translate(JPLocaleKeys.billName),
                    hint: context.translate(JPLocaleKeys.billNameHint),
                    inputAction: TextInputAction.next,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        if (text.length < 3) {
                          return context.translate(
                            JPLocaleKeys.billNameValidatorError,
                          );
                        }
                      }
                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedAmount && hasTriedToSendWithPending)
                    _JPTextError(
                      context.translate(JPLocaleKeys.billAmountError),
                    ),
                  JPTextFormField(
                    controller: amountController,
                    label: context.translate(JPLocaleKeys.billAmount),
                    hint: '${context.currency} 100,00',
                    inputFormatters: [context.currencyTextInputFormatter],
                    keyboardType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double amount = context.currencyIntoDouble(text);
                        if (amount == 0) {
                          return context.translate(
                            JPLocaleKeys.billAmountValidatorError,
                          );
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedDueDay && hasTriedToSendWithPending)
                    _JPTextError(
                      context.translate(JPLocaleKeys.billDueDateError),
                    ),
                  JPTextFormField(
                    controller: dueDayController,
                    label: context.translate(JPLocaleKeys.billDueDate),
                    hint: '01',
                    keyboardType: TextInputType.number,
                    inputFormatters: [context.dueDayInput],
                    inputAction: TextInputAction.done,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        int value = int.parse(text);
                        if (value > 31 || (value == 0 && text.length == 2)) {
                          return context.translate(
                            JPLocaleKeys.billDueDateValidatorError,
                          );
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedPaymentMethod && hasTriedToSendWithPending)
                    _JPTextError(
                      context.translate(JPLocaleKeys.billPaymentMethodError),
                    ),
                  JPSelectionTile(
                    title: context.translate(JPLocaleKeys.billPaymentMethod),
                    info: paymentMethod != null
                        ? context.translate(paymentMethod!.name)
                        : context.translate(JPLocaleKeys.billPaymentMethodHint),
                    onTap: () {
                      context.showModal(
                        child: JPSelectionModal(
                          title: context.translate(
                            JPLocaleKeys.billPaymentMethod,
                          ),
                          preSelectedValue: context.translate(
                            paymentMethod?.name,
                          ),
                          items: BillPaymentMethodEnum.paymentMethods(context),
                          onTapPrimaryButton: (newPaymentMethod) {
                            paymentMethod = BillPaymentMethodEnum.values
                                .firstWhere(
                                  (e) =>
                                      context.translate(e.name) ==
                                      newPaymentMethod,
                                );
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                  JPSpacingVertical.l,
                  JPSelectionSwitch(
                    label: context.translate(
                      JPLocaleKeys.billHasVariableAmount,
                    ),
                    isSelected: isVariableAmount ?? false,
                    onTap: (newVariableAmount) {
                      isVariableAmount = newVariableAmount;
                      setState(() {});
                    },
                  ),
                  if (isEdition) ...[
                    JPSpacingVertical.m,
                    JPSelectionTile(
                      title: context.translate(JPLocaleKeys.billDeleteTitle),
                      info: context.translate(JPLocaleKeys.billDeleteInfo),
                      onTap: () {
                        context.showModal(
                          child: JPConfirmationModal(
                            title: context.translate(
                              JPLocaleKeys.billDeleteModalTitle,
                            ),
                            primaryButtonLabel: context.translate(
                              JPLocaleKeys.delete,
                            ),
                            onTapPrimaryButton: () {
                              dataBaseViewModel.deleteBill(editBill!);
                              context.popUntilIsRoot();
                              context.showSnackInfo(
                                context.translate(
                                  JPLocaleKeys.billDeleteModalSnackBar,
                                ),
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
                            amount: context.currencyIntoDouble(
                              amountController.text,
                            ),
                            dueDay: int.parse(dueDayController.text),
                            paymentMethod: paymentMethod,
                            isVariableAmount: isVariableAmount,
                          );

                          dataBaseViewModel.updateBill(newBillModel);
                          context.showSnackInfo(
                            context.translate(JPLocaleKeys.billEditedSnackBar),
                          );
                        } else {
                          BillModel newBillModel = BillModel(
                            id: null,
                            name: nameController.text,
                            amount: context.currencyIntoDouble(
                              amountController.text,
                            ),
                            dueDay: int.parse(dueDayController.text),
                            paymentMethod: paymentMethod!,
                            isVariableAmount: isVariableAmount ?? false,
                          );

                          bool hasCreated = dataBaseViewModel.createBill(
                            newBillModel,
                          );
                          if (!hasCreated) {
                            context.showSnackError(
                              context.translate(
                                JPLocaleKeys.billCreatedSnackBarError,
                              ),
                            );
                            return;
                          }
                          context.showSnackSuccess(
                            context.translate(JPLocaleKeys.billCreatedSnackBar),
                          );
                        }
                        context.popUntilIsRoot();
                        return;
                      } else {
                        hasTriedToSendWithPending = true;
                        context.showSnackError(
                          context.translate(JPLocaleKeys.billError),
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
                            primaryButtonLabel: context.translate(
                              JPLocaleKeys.cancel,
                            ),
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
