import 'dart:ui';

import 'locale_keys.dart';

class LocaleValues {
  const LocaleValues();

  static String translate(String languageCode, String? key) {
    if (key == null || key.isEmpty) {
      return '';
    }

    if (languageCode == 'pt') {
      return pt[key]!;
    }

    return en[key]!;
  }

  static const Map<String, String> en = {
    LocaleKeys.title: 'Hello',
    LocaleKeys.alreadyPaid: 'Already paid',
    LocaleKeys.currency: '\$',
    LocaleKeys.save: 'Save',
    LocaleKeys.cancel: 'Cancel',
    LocaleKeys.edit: 'Edit',
    LocaleKeys.variableAmount: 'Variable amount',

    /// BillPaymentMethodEnum
    LocaleKeys.creditCard: 'Credit card',
    LocaleKeys.automaticDebit: 'Automatic debit',
    LocaleKeys.bankSlip: 'Bank slip',
    LocaleKeys.pix: 'Bank transfer',
    LocaleKeys.money: 'Cash',

    /// BillStatusEnum
    LocaleKeys.pending: 'Pending',
    LocaleKeys.paid: 'Paid',
    LocaleKeys.overdue: 'Overdue',
    LocaleKeys.overdueToday: 'Due today',
    LocaleKeys.overdueTomorrow: 'Due tomorrow',

    /// BaseModel
    LocaleKeys.dueDate: 'Due date',
    LocaleKeys.onTheDay: 'On the',
    LocaleKeys.paidOn: 'Paid on',

    /// BillPage
    LocaleKeys.editBill: 'Edit bill',
    LocaleKeys.createBill: 'Create bill',
    LocaleKeys.cancelEditBill: 'Cancel editing?',
    LocaleKeys.cancelCreateBill: 'Do you want to cancel?',

    //TODO transalate from here
    LocaleKeys.cancelEditBillModalInfo:
        'By confirming, you will lose all edited information.',
    LocaleKeys.cancelCreateBillModalInfo:
        'By confirming, you will lose all created information.',
    LocaleKeys.cancelEditBillModalButtonLabel: 'Continue editing',
    LocaleKeys.cancelCreateBillModalButtonLabel: 'Continue creating',
    LocaleKeys.billNameError: ' Please enter the bill name',
    LocaleKeys.billName: 'Bill name',
    LocaleKeys.billNameHint: 'Water bill',
    LocaleKeys.billNameValidatorError: 'Please enter a valid name.',
    LocaleKeys.billAmountError: 'Please enter the bill amount',
    LocaleKeys.billAmount: 'Bill amount',
    LocaleKeys.billAmountValidatorError: 'Please enter a valid amount.',
    LocaleKeys.billDueDateError: 'Please enter the due date',
    LocaleKeys.billDueDate: 'Due date',
    LocaleKeys.billDueDateValidatorError: 'Please enter a valid date.',
    LocaleKeys.billPaymentMethodError: 'Please enter the payment method',
    LocaleKeys.billPaymentMethod: 'Payment method',
    LocaleKeys.billPaymentMethodHint: 'Select the payment method',
    LocaleKeys.billHasVariableAmount: 'Does this bill have a variable amount?',
    LocaleKeys.billDeleteTitle: 'Não tem mais essa conta?',
    LocaleKeys.billDeleteInfo: 'Deletar conta',
    LocaleKeys.billDeleteModalTitle: 'Deseja deletar essa conta?',
    LocaleKeys.billDeleteModalLabel: 'Deletar',
    LocaleKeys.billDeleteModalSnackBar: 'Conta deletada com sucesso.',
    LocaleKeys.billEditedSnackBar: 'Conta editada com sucesso.',
    LocaleKeys.billCreatedSnackBarError: 'Já existe uma conta com esse nome.',
    LocaleKeys.billCreatedSnackBar: 'Conta criada com sucesso.',
    LocaleKeys.billError: 'Por favor preencha todos os dados',

    /// BillPaymentDatePage
    LocaleKeys.dateTitle: 'Em qual data a conta foi paga?',

    /// BillVariableValuePage
    LocaleKeys.variableAmountTitle: 'Qual foi o valor pago?',
    LocaleKeys.variableAmountLabel: 'Valor',
    LocaleKeys.variableAmountValidatorError: 'Digite um valor valido.',

    /// BillVariableValuePage
    LocaleKeys.homeAccount: 'Conta',
    LocaleKeys.homeAccountTab: 'Contas',
    LocaleKeys.homeHistoryTab: 'Histórico',
    LocaleKeys.homeBalanceTab: 'Balanço',

    /// BillConfirmationModalWidget
    LocaleKeys.billConfirmationModalTitle: 'Essa conta já foi paga?',
    LocaleKeys.billConfirmationModalPrimaryButtonLabel: 'Sim, já foi paga',
    LocaleKeys.billConfirmationModalSecondaryButtonLabel: 'Não, ainda não',
    LocaleKeys.billConfirmationModalSnack: 'Conta paga!',
    LocaleKeys.billConfirmationModalDateTitle: 'Data que foi paga',
  };

  static const Map<String, String> pt = {
    LocaleKeys.title: 'Hello',
    LocaleKeys.alreadyPaid: 'Já paguei',
    LocaleKeys.currency: 'R\$',
    LocaleKeys.save: 'Salvar',
    LocaleKeys.cancel: 'Cancelar',
    LocaleKeys.edit: 'Editar',
    LocaleKeys.variableAmount: 'Valor variável',

    /// BillPaymentMethodEnum
    LocaleKeys.creditCard: 'Cartão de crédito',
    LocaleKeys.automaticDebit: 'Débito automático',
    LocaleKeys.bankSlip: 'Boleto',
    LocaleKeys.pix: 'Pix',
    LocaleKeys.money: 'Dinheiro',

    /// BillStatusEnum
    LocaleKeys.pending: 'Pendente',
    LocaleKeys.paid: 'Paga',
    LocaleKeys.overdue: 'Vencida',
    LocaleKeys.overdueToday: 'Vence hoje',
    LocaleKeys.overdueTomorrow: 'Vence amanhã',

    /// BaseModel
    LocaleKeys.dueDate: 'Vencimento',
    LocaleKeys.onTheDay: 'Todo dia',
    LocaleKeys.paidOn: 'Paga em',

    /// BillPage
    LocaleKeys.editBill: 'Editar conta',
    LocaleKeys.createBill: 'Criar conta',
    LocaleKeys.cancelEditBill: 'Deseja cancelar edição?',
    LocaleKeys.cancelCreateBill: 'Deseja cancelar?',
    LocaleKeys.cancelEditBillModalInfo:
        'Ao confirmar você perderá todas as informações editadas.',
    LocaleKeys.cancelCreateBillModalInfo:
        'Ao confirmar você perderá todas as informações criadas.',
    LocaleKeys.cancelEditBillModalButtonLabel: 'Continuar edição',
    LocaleKeys.cancelCreateBillModalButtonLabel: 'Continuar criação',
    LocaleKeys.billNameError: 'Preencha o nome da conta',
    LocaleKeys.billName: 'Nome da conta',
    LocaleKeys.billNameHint: 'Conta de água',
    LocaleKeys.billNameValidatorError: 'Digite um nome valido.',
    LocaleKeys.billAmountError: 'Preencha o valor da conta',
    LocaleKeys.billAmount: 'Valor da conta',
    LocaleKeys.billAmountValidatorError: 'Digite um valor valido.',
    LocaleKeys.billDueDateError: 'Preencha o dia de vencimento',
    LocaleKeys.billDueDate: 'Dia de vencimento',
    LocaleKeys.billDueDateValidatorError: 'Digite um dia valido.',
    LocaleKeys.billPaymentMethodError: 'Preencha o método de pagamento',
    LocaleKeys.billPaymentMethod: 'Método de pagamento',
    LocaleKeys.billPaymentMethodHint: 'Selecione o método de pagamento',
    LocaleKeys.billHasVariableAmount: 'Essa conta tem valor variável?',
    LocaleKeys.billDeleteTitle: 'Não tem mais essa conta?',
    LocaleKeys.billDeleteInfo: 'Deletar conta',
    LocaleKeys.billDeleteModalTitle: 'Deseja deletar essa conta?',
    LocaleKeys.billDeleteModalLabel: 'Deletar',
    LocaleKeys.billDeleteModalSnackBar: 'Conta deletada com sucesso.',
    LocaleKeys.billEditedSnackBar: 'Conta editada com sucesso.',
    LocaleKeys.billCreatedSnackBarError: 'Já existe uma conta com esse nome.',
    LocaleKeys.billCreatedSnackBar: 'Conta criada com sucesso.',
    LocaleKeys.billError: 'Por favor preencha todos os dados',

    /// BillPaymentDatePage
    LocaleKeys.dateTitle: 'Em qual data a conta foi paga?',

    /// BillVariableValuePage
    LocaleKeys.variableAmountTitle: 'Qual foi o valor pago?',
    LocaleKeys.variableAmountLabel: 'Valor',
    LocaleKeys.variableAmountValidatorError: 'Digite um valor valido.',

    /// BillVariableValuePage
    LocaleKeys.homeAccount: 'Conta',
    LocaleKeys.homeAccountTab: 'Contas',
    LocaleKeys.homeHistoryTab: 'Histórico',
    LocaleKeys.homeBalanceTab: 'Balanço',

    /// BillConfirmationModalWidget
    LocaleKeys.billConfirmationModalTitle: 'Essa conta já foi paga?',
    LocaleKeys.billConfirmationModalPrimaryButtonLabel: 'Sim, já foi paga',
    LocaleKeys.billConfirmationModalSecondaryButtonLabel: 'Não, ainda não',
    LocaleKeys.billConfirmationModalSnack: 'Conta paga!',
    LocaleKeys.billConfirmationModalDateTitle: 'Data que foi paga',
  };

  static const Map<String, Map<String, String>> mapLocales = {
    'en_US': en,
    'en': en,
    'pt_BR': pt,
    'pt': pt,
  };

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('pt', 'BR'),
  ];
}
