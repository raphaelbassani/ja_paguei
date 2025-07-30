class HistoryFields {
  static const String tableName = 'history';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String id = '_id';
  static const String billId = 'billId';
  static const String name = 'name';
  static const String amount = 'amount';
  static const String paymentMethod = 'paymentMethod';
  static const String dueDay = 'dueDay';
  static const String isVariableAmount = 'isVariableAmount';
  static const String paymentDateTime = 'paymentDateTime';

  static const List<String> values = [
    id,
    billId,
    name,
    amount,
    paymentMethod,
    dueDay,
    isVariableAmount,
    paymentDateTime,
  ];
}
