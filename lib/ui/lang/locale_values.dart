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
  };

  // static const Map<String, dynamic> en = { EXAMPLE
  //   'title': 'Hello',
  //   'msg': 'Hello {} in the {} world ',
  //   'msg_named': '{} are written in the {lang} language',
  //   'clickMe': 'Click me',
  //   'profile': {
  //     'reset_password': {
  //       'label': 'Reset Password',
  //       'username': 'Username',
  //       'password': 'password',
  //     },
  //   },
  //   'clicked': {
  //     'zero': 'You clicked {} times!',
  //     'one': 'You clicked {} time!',
  //     'two': 'You clicked {} times!',
  //     'few': 'You clicked {} times!',
  //     'many': 'You clicked {} times!',
  //     'other': 'You clicked {} times!',
  //   },
  //   'amount': {
  //     'zero': 'Your amount : {} ',
  //     'one': 'Your amount : {} ',
  //     'two': 'Your amount : {} ',
  //     'few': 'Your amount : {} ',
  //     'many': 'Your amount : {} ',
  //     'other': 'Your amount : {} ',
  //   },
  //   'gender': {
  //     'male': 'Hi man ;) ',
  //     'female': 'Hello girl :)',
  //     'with_arg': {'male': 'Hi man ;) {}', 'female': 'Hello girl :) {}'},
  //   },
  //   'reset_locale': 'Reset Language',
  // };

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
