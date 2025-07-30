class BillFields {
  static const String tableName = 'bills';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String id = '_id';
  static const String name = 'name';
  static const String amount = 'amount';
  static const String paymentMethod = 'paymentMethod';
  static const String dueDay = 'dueDay';
  static const String status = 'status';
  static const String isVariableAmount = 'isVariableAmount';
  static const String paymentDateTime = 'paymentDateTime';
  static const String createdAt = 'createdAt';

  static const List<String> values = [
    id,
    name,
    amount,
    paymentMethod,
    dueDay,
    status,
    isVariableAmount,
    paymentDateTime,
    createdAt,
  ];
}
