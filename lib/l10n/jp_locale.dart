import 'dart:ui';

import 'l10n.dart';

class JPLocale {
  const JPLocale();

  static String translate(String languageCode, String? key) {
    if (key == null || key.isEmpty) {
      return '';
    }

    if (languageCode == JPLocaleKeys.pt) {
      return pt[key]!;
    }

    return en[key]!;
  }

  static const Map<String, String> en = {
    JPLocaleKeys.alreadyPaid: 'Already paid',
    JPLocaleKeys.currency: '\$',
    JPLocaleKeys.save: 'Save',
    JPLocaleKeys.confirm: 'Confirm',
    JPLocaleKeys.cancel: 'Cancel',
    JPLocaleKeys.delete: 'Delete',
    JPLocaleKeys.edit: 'Edit',
    JPLocaleKeys.variableAmount: 'Variable amount',

    /// Languages
    JPLocaleKeys.en: 'English',
    JPLocaleKeys.pt: 'Português',

    /// Months
    JPLocaleKeys.jan: 'Jan',
    JPLocaleKeys.feb: 'Feb',
    JPLocaleKeys.mar: 'Mar',
    JPLocaleKeys.apr: 'Apr',
    JPLocaleKeys.may: 'May',
    JPLocaleKeys.jun: 'Jun',
    JPLocaleKeys.jul: 'Jul',
    JPLocaleKeys.aug: 'Aug',
    JPLocaleKeys.sep: 'Sep',
    JPLocaleKeys.oct: 'Oct',
    JPLocaleKeys.nov: 'Nov',
    JPLocaleKeys.dec: 'Dec',

    /// BillPaymentMethodEnum
    JPLocaleKeys.creditCard: 'Credit card',
    JPLocaleKeys.automaticDebit: 'Automatic debit',
    JPLocaleKeys.bankSlip: 'Bank slip',
    JPLocaleKeys.pix: 'Bank transfer',
    JPLocaleKeys.money: 'Cash',

    /// BillStatusEnum
    JPLocaleKeys.pending: 'Pending',
    JPLocaleKeys.paid: 'Paid',
    JPLocaleKeys.overdue: 'Overdue',
    JPLocaleKeys.overdueToday: 'Due today',
    JPLocaleKeys.overdueTomorrow: 'Due tomorrow',

    /// BaseModel
    JPLocaleKeys.dueDate: 'Due date',
    JPLocaleKeys.onTheDay: 'On the',
    JPLocaleKeys.paidOn: 'Paid on',

    /// BillPage
    JPLocaleKeys.editBill: 'Edit bill',
    JPLocaleKeys.createBill: 'Create bill',
    JPLocaleKeys.cancelEditBill: 'Cancel editing?',
    JPLocaleKeys.cancelCreateBill: 'Do you want to cancel?',
    JPLocaleKeys.cancelEditBillModalInfo:
        'By confirming, you will lose all edited information.',
    JPLocaleKeys.cancelCreateBillModalInfo:
        'By confirming, you will lose all created information.',
    JPLocaleKeys.cancelEditBillModalButtonLabel: 'Continue editing',
    JPLocaleKeys.cancelCreateBillModalButtonLabel: 'Continue creating',
    JPLocaleKeys.billNameError: ' Please enter the bill name',
    JPLocaleKeys.billName: 'Bill name',
    JPLocaleKeys.billNameHint: 'Water bill',
    JPLocaleKeys.billNameValidatorError: 'Please enter a valid name.',
    JPLocaleKeys.billAmountError: 'Please enter the bill amount',
    JPLocaleKeys.billAmount: 'Bill amount',
    JPLocaleKeys.billAmountValidatorError: 'Please enter a valid amount.',
    JPLocaleKeys.billDueDateError: 'Please enter the due date',
    JPLocaleKeys.billDueDate: 'Due date',
    JPLocaleKeys.billDueDateValidatorError: 'Please enter a valid date.',
    JPLocaleKeys.billPaymentMethodError: 'Please enter the payment method',
    JPLocaleKeys.billPaymentMethod: 'Payment method',
    JPLocaleKeys.billPaymentMethodHint: 'Select the payment method',
    JPLocaleKeys.billHasVariableAmount:
        'Does this bill have a variable amount?',
    JPLocaleKeys.billDeleteTitle: 'Don\'t have this bill anymore?',
    JPLocaleKeys.billDeleteInfo: 'Delete bill',
    JPLocaleKeys.billDeleteModalTitle: 'Do you want to delete this bill?',
    JPLocaleKeys.billDeleteModalSnackBar: 'Bill successfully deleted.',
    JPLocaleKeys.billEditedSnackBar: 'Bill successfully edited.',
    JPLocaleKeys.billCreatedSnackBarError:
        'A bill with this name already exists.',
    JPLocaleKeys.billCreatedSnackBar: 'Bill successfully created.',
    JPLocaleKeys.billError: 'Please fill in all the information',

    /// BillPaymentDatePage
    JPLocaleKeys.dateTitle: 'When was the bill paid?',

    /// BillVariableAmountPage
    JPLocaleKeys.variableAmountTitle: 'How much was paid?',
    JPLocaleKeys.variableAmountLabel: 'Amount',
    JPLocaleKeys.variableAmountValidatorError: ' Please enter a valid amount.',

    /// HomePage
    JPLocaleKeys.homeAccount: 'Bill',
    JPLocaleKeys.homeAccountTab: 'Bills',
    JPLocaleKeys.homeHistoryTab: 'History',
    JPLocaleKeys.homeBalanceTab: 'Balance',
    JPLocaleKeys.homeSettingsTab: 'Settings',

    /// BillConfirmationModalWidget
    JPLocaleKeys.billConfirmationModalTitle: 'Has this bill already been paid?',
    JPLocaleKeys.billConfirmationModalPrimaryButtonLabel:
        'Yes, it has been paid',
    JPLocaleKeys.billConfirmationModalSecondaryButtonLabel: 'No, not yet',
    JPLocaleKeys.billConfirmationModalSnack: 'Bill paid!',
    JPLocaleKeys.billConfirmationModalDateTitle: 'Date that it was paid',
    JPLocaleKeys.billConfirmationModalDateSubtitle: 'Date that it was paid',

    /// HistoryTabWidget
    JPLocaleKeys.historyDeletePayment: 'Delete payment',

    /// SettingsTabWidget
    JPLocaleKeys.settingsDarkMode: 'Dark mode',
    JPLocaleKeys.settingsLanguage: 'Language',
    JPLocaleKeys.settingsSelectLanguage: 'Select language',
  };

  static const Map<String, String> pt = {
    JPLocaleKeys.alreadyPaid: 'Já paguei',
    JPLocaleKeys.currency: 'R\$',
    JPLocaleKeys.save: 'Salvar',
    JPLocaleKeys.confirm: 'Confirmar',
    JPLocaleKeys.cancel: 'Cancelar',
    JPLocaleKeys.delete: 'Deletar',
    JPLocaleKeys.edit: 'Editar',
    JPLocaleKeys.variableAmount: 'Valor variável',

    /// Languages
    JPLocaleKeys.en: 'English',
    JPLocaleKeys.pt: 'Português',

    ///Months
    JPLocaleKeys.jan: 'Jan',
    JPLocaleKeys.feb: 'Fev',
    JPLocaleKeys.mar: 'Mar',
    JPLocaleKeys.apr: 'Abr',
    JPLocaleKeys.may: 'Mai',
    JPLocaleKeys.jun: 'Jun',
    JPLocaleKeys.jul: 'Jul',
    JPLocaleKeys.aug: 'Ago',
    JPLocaleKeys.sep: 'Set',
    JPLocaleKeys.oct: 'Out',
    JPLocaleKeys.nov: 'Nov',
    JPLocaleKeys.dec: 'Dez',

    /// BillPaymentMethodEnum
    JPLocaleKeys.creditCard: 'Cartão de crédito',
    JPLocaleKeys.automaticDebit: 'Débito automático',
    JPLocaleKeys.bankSlip: 'Boleto',
    JPLocaleKeys.pix: 'Pix',
    JPLocaleKeys.money: 'Dinheiro',

    /// BillStatusEnum
    JPLocaleKeys.pending: 'Pendente',
    JPLocaleKeys.paid: 'Paga',
    JPLocaleKeys.overdue: 'Vencida',
    JPLocaleKeys.overdueToday: 'Vence hoje',
    JPLocaleKeys.overdueTomorrow: 'Vence amanhã',

    /// BaseModel
    JPLocaleKeys.dueDate: 'Vencimento',
    JPLocaleKeys.onTheDay: 'Todo dia',
    JPLocaleKeys.paidOn: 'Paga em',

    /// BillPage
    JPLocaleKeys.editBill: 'Editar conta',
    JPLocaleKeys.createBill: 'Criar conta',
    JPLocaleKeys.cancelEditBill: 'Deseja cancelar edição?',
    JPLocaleKeys.cancelCreateBill: 'Deseja cancelar?',
    JPLocaleKeys.cancelEditBillModalInfo:
        'Ao confirmar você perderá todas as informações editadas.',
    JPLocaleKeys.cancelCreateBillModalInfo:
        'Ao confirmar você perderá todas as informações criadas.',
    JPLocaleKeys.cancelEditBillModalButtonLabel: 'Continuar edição',
    JPLocaleKeys.cancelCreateBillModalButtonLabel: 'Continuar criação',
    JPLocaleKeys.billNameError: 'Preencha o nome da conta',
    JPLocaleKeys.billName: 'Nome da conta',
    JPLocaleKeys.billNameHint: 'Conta de água',
    JPLocaleKeys.billNameValidatorError: 'Digite um nome valido.',
    JPLocaleKeys.billAmountError: 'Preencha o valor da conta',
    JPLocaleKeys.billAmount: 'Valor da conta',
    JPLocaleKeys.billAmountValidatorError: 'Digite um valor valido.',
    JPLocaleKeys.billDueDateError: 'Preencha o dia de vencimento',
    JPLocaleKeys.billDueDate: 'Dia de vencimento',
    JPLocaleKeys.billDueDateValidatorError: 'Digite um dia valido.',
    JPLocaleKeys.billPaymentMethodError: 'Preencha o método de pagamento',
    JPLocaleKeys.billPaymentMethod: 'Método de pagamento',
    JPLocaleKeys.billPaymentMethodHint: 'Selecione o método de pagamento',
    JPLocaleKeys.billHasVariableAmount: 'Essa conta tem valor variável?',
    JPLocaleKeys.billDeleteTitle: 'Não tem mais essa conta?',
    JPLocaleKeys.billDeleteInfo: 'Deletar conta',
    JPLocaleKeys.billDeleteModalTitle: 'Deseja deletar essa conta?',
    JPLocaleKeys.billDeleteModalSnackBar: 'Conta deletada com sucesso.',
    JPLocaleKeys.billEditedSnackBar: 'Conta editada com sucesso.',
    JPLocaleKeys.billCreatedSnackBarError: 'Já existe uma conta com esse nome.',
    JPLocaleKeys.billCreatedSnackBar: 'Conta criada com sucesso.',
    JPLocaleKeys.billError: 'Por favor preencha todos os dados',

    /// BillPaymentDatePage
    JPLocaleKeys.dateTitle: 'Em qual data a conta foi paga?',

    /// BillVariableAmountPage
    JPLocaleKeys.variableAmountTitle: 'Qual foi o valor pago?',
    JPLocaleKeys.variableAmountLabel: 'Valor',
    JPLocaleKeys.variableAmountValidatorError: 'Digite um valor valido.',

    /// HomePage
    JPLocaleKeys.homeAccount: 'Conta',
    JPLocaleKeys.homeAccountTab: 'Contas',
    JPLocaleKeys.homeHistoryTab: 'Histórico',
    JPLocaleKeys.homeBalanceTab: 'Balanço',
    JPLocaleKeys.homeSettingsTab: 'Ajustes',

    /// BillConfirmationModalWidget
    JPLocaleKeys.billConfirmationModalTitle: 'Essa conta já foi paga?',
    JPLocaleKeys.billConfirmationModalPrimaryButtonLabel: 'Sim, já foi paga',
    JPLocaleKeys.billConfirmationModalSecondaryButtonLabel: 'Não, ainda não',
    JPLocaleKeys.billConfirmationModalSnack: 'Conta paga!',
    JPLocaleKeys.billConfirmationModalDateTitle: 'Data que foi paga',
    JPLocaleKeys.billConfirmationModalDateSubtitle:
        'A conta já foi paga nesse dia, '
        'deseja pagar novamente?',

    /// HistoryTabWidget
    JPLocaleKeys.historyDeletePayment: 'Deletar pagamento',

    /// SettingsTabWidget
    JPLocaleKeys.settingsDarkMode: 'Modo escuro',
    JPLocaleKeys.settingsLanguage: 'Idioma',
    JPLocaleKeys.settingsSelectLanguage: 'Selecionar idioma',
  };

  static const Map<String, Map<String, String>> mapLocales = {
    'en_US': en,
    JPLocaleKeys.en: en,
    'pt_BR': pt,
    JPLocaleKeys.pt: pt,
  };

  static const List<Locale> supportedLocales = [
    Locale(JPLocaleKeys.en, 'US'),
    Locale(JPLocaleKeys.en),
    Locale('en_US'),
    Locale(JPLocaleKeys.pt, 'BR'),
    Locale(JPLocaleKeys.pt),
    Locale('pt_BR'),
  ];
}
