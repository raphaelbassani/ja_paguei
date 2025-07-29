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
    LocaleKeys.currency: '\$',
    LocaleKeys.creditCard: 'Credit card',
    LocaleKeys.automaticDebit: 'Automatic debit',
    LocaleKeys.bankSlip: 'Bank slip',
    LocaleKeys.pix: 'Bank transfer',
    LocaleKeys.money: 'Cash',
    LocaleKeys.pending: 'Pending',
    LocaleKeys.payed: 'Payed',
    LocaleKeys.overdue: 'Overdue',
    LocaleKeys.overdueToday: 'Due today',
    LocaleKeys.overdueTomorrow: 'Due tomorrow',
    LocaleKeys.dueDate: 'Due date',
    LocaleKeys.onTheDay: 'On the',
    LocaleKeys.paidOn: 'Paid on',
    LocaleKeys.editBill: 'Edit bill',
    LocaleKeys.createBill: 'Create bill',
    LocaleKeys.cancelEditBill: 'Cancel editing?',
    LocaleKeys.cancelCreateBill: 'Do you want to cancel?',
    //TODO transalate from here
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
  };

  static const Map<String, String> pt = {
    LocaleKeys.title: 'Hello',
    LocaleKeys.currency: 'R\$',
    LocaleKeys.creditCard: 'Cartão de crédito',
    LocaleKeys.automaticDebit: 'Débito automático',
    LocaleKeys.bankSlip: 'Boleto',
    LocaleKeys.pix: 'Pix',
    LocaleKeys.money: 'Dinheiro',
    LocaleKeys.pending: 'Pendente',
    LocaleKeys.payed: 'Paga',
    LocaleKeys.overdue: 'Vencida',
    LocaleKeys.overdueToday: 'Vence hoje',
    LocaleKeys.overdueTomorrow: 'Vence amanhã',
    LocaleKeys.dueDate: 'Vencimento',
    LocaleKeys.onTheDay: 'Todo dia',
    LocaleKeys.paidOn: 'Paga em',
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
