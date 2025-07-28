import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/payment_history_model.dart';

class PaymentHistoryDatabase {
  static final PaymentHistoryDatabase instance =
      PaymentHistoryDatabase._internal();

  static Database? _database;

  PaymentHistoryDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'payment_history.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE ${PaymentHistoryFields.tableName} (
          ${PaymentHistoryFields.id} ${PaymentHistoryFields.idType},
          ${PaymentHistoryFields.billId} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.name} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.value} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.paymentMethod} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.dueDay} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.isVariableValue} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.paymentDateTime} ${PaymentHistoryFields.textType}
        )
      ''');
  }

  Future<void> save(PaymentHistoryModel payment) async {
    final db = await instance.database;
    await db.insert(PaymentHistoryFields.tableName, payment.toJson());
  }

  Future<List<PaymentHistoryModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(PaymentHistoryFields.tableName);
    final List<PaymentHistoryModel> listResult = result
        .map((json) => PaymentHistoryModel.fromJson(json))
        .toList();
    final List<PaymentHistoryModel> sortedList = listResult
      ..sort((a, b) => b.paymentDateTime!.compareTo(a.paymentDateTime!));
    return sortedList;
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

class PaymentHistoryFields {
  static const String tableName = 'payment_history';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String id = '_id';
  static const String billId = 'billId';
  static const String name = 'name';
  static const String value = 'value';
  static const String paymentMethod = 'paymentMethod';
  static const String dueDay = 'dueDay';
  static const String isVariableValue = 'isVariableValue';
  static const String paymentDateTime = 'paymentDateTime';

  static const List<String> values = [
    id,
    billId,
    name,
    value,
    paymentMethod,
    dueDay,
    isVariableValue,
    paymentDateTime,
  ];
}
