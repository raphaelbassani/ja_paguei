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

  String get mainLabel => isEdition
      ? context.translate(LocaleKeys.editBill)
      : context.translate(LocaleKeys.createBill);

  String get cancelModalTitle => isEdition
      ? context.translate(LocaleKeys.cancelEditBill)
      : context.translate(LocaleKeys.cancelCreateBill);

  String get cancelModalInfo => isEdition
      ? context.translate(LocaleKeys.cancelEditBillModalInfo)
      : context.translate(LocaleKeys.cancelCreateBillModalInfo);

  String get cancelModalButtonLabel => isEdition
      ? context.translate(LocaleKeys.cancelEditBillModalButtonLabel)
      : context.translate(LocaleKeys.cancelCreateBillModalButtonLabel);

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
                    _JPTextError(context.translate(LocaleKeys.billNameError)),
                  JPTextFormField(
                    controller: nameController,
                    label: context.translate(LocaleKeys.billName),
                    hint: context.translate(LocaleKeys.billNameHint),
                    inputAction: TextInputAction.next,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        if (text.length < 3) {
                          return context.translate(
                            LocaleKeys.billNameValidatorError,
                          );
                        }
                      }
                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedValue && hasTriedToSendWithPending)
                    _JPTextError(context.translate(LocaleKeys.billValueError)),
                  JPTextFormField(
                    controller: valueController,
                    label: context.translate(LocaleKeys.billValue),
                    hint: '${context.currency} 100,00',
                    inputFormatters: [context.currencyTextInputFormatter],
                    keyboardType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        double value = context.currencyIntoDouble(text);
                        if (value == 0) {
                          return context.translate(
                            LocaleKeys.billValueValidatorError,
                          );
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedDueDay && hasTriedToSendWithPending)
                    _JPTextError(
                      context.translate(LocaleKeys.billDueDateError),
                    ),
                  JPTextFormField(
                    controller: dueDayController,
                    label: context.translate(LocaleKeys.billDueDate),
                    hint: '01',
                    keyboardType: TextInputType.number,
                    inputFormatters: [context.dueDayInput],
                    inputAction: TextInputAction.done,
                    validator: (text) {
                      if (text != null && text.isNotEmpty) {
                        int value = int.parse(text);
                        if (value > 31 || (value == 0 && text.length == 2)) {
                          return context.translate(
                            LocaleKeys.billDueDateValidatorError,
                          );
                        }
                      }

                      return null;
                    },
                  ),
                  JPSpacingVertical.l,
                  if (!hasEditedPaymentMethod && hasTriedToSendWithPending)
                    _JPTextError(
                      context.translate(LocaleKeys.billPaymentMethodError),
                    ),
                  JPSelectionTile(
                    title: context.translate(LocaleKeys.billPaymentMethod),
                    info: paymentMethod != null
                        ? context.translate(paymentMethod!.name)
                        : context.translate(LocaleKeys.billPaymentMethodHint),
                    onTap: () {
                      context.showModal(
                        child: JPSelectionModal(
                          title: context.translate(
                            LocaleKeys.billPaymentMethod,
                          ),
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
                    label: context.translate(LocaleKeys.billHasVariableValue),
                    isSelected: isVariableValue ?? false,
                    onTap: (newVariableValue) {
                      isVariableValue = newVariableValue;
                      setState(() {});
                    },
                  ),
                  if (isEdition) ...[
                    JPSpacingVertical.m,
                    JPSelectionTile(
                      title: context.translate(LocaleKeys.billDeleteTitle),
                      info: context.translate(LocaleKeys.billDeleteInfo),
                      onTap: () {
                        context.showModal(
                          child: JPConfirmationModal(
                            title: context.translate(
                              LocaleKeys.billDeleteModalTitle,
                            ),
                            primaryButtonLabel: context.translate(
                              LocaleKeys.billDeleteModalLabel,
                            ),
                            onTapPrimaryButton: () {
                              dataBaseViewModel.deleteBill(editBill!);
                              context.popUntilIsRoot();
                              context.showSnackInfo(
                                context.translate(
                                  LocaleKeys.billDeleteModalSnackBar,
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
                            value: context.currencyIntoDouble(
                              valueController.text,
                            ),
                            dueDay: int.parse(dueDayController.text),
                            paymentMethod: paymentMethod,
                            isVariableValue: isVariableValue,
                          );

                          dataBaseViewModel.updateBill(newBillModel);
                          context.showSnackInfo(
                            context.translate(LocaleKeys.billEditedSnackBar),
                          );
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
                              context.translate(
                                LocaleKeys.billCreatedSnackBarError,
                              ),
                            );
                            return;
                          }
                          context.showSnackSuccess(
                            context.translate(LocaleKeys.billCreatedSnackBar),
                          );
                        }
                        context.popUntilIsRoot();
                        return;
                      } else {
                        hasTriedToSendWithPending = true;
                        context.showSnackError(
                          context.translate(LocaleKeys.billError),
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
                              LocaleKeys.cancel,
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
