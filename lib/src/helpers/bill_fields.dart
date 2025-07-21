class BillFields {
  static const String tableName = 'bills';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String id = '_id';
  static const String name = 'name';
  static const String value = 'value';
  static const String paymentMethod = 'paymentMethod';
  static const String dueDay = 'dueDay';
  static const String status = 'status';
  static const String isVariableValue = 'isVariableValue';
  static const String paymentDateTime = 'paymentDateTime';

  static const List<String> values = [
    id,
    name,
    value,
    paymentMethod,
    dueDay,
    status,
    isVariableValue,
    paymentDateTime,
  ];
}
