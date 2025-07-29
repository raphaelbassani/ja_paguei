import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/history_model.dart';

class HistoryDatabase {
  static final HistoryDatabase instance = HistoryDatabase._internal();

  static Database? _database;

  HistoryDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'history.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE ${HistoryFields.tableName} (
          ${HistoryFields.id} ${HistoryFields.idType},
          ${HistoryFields.billId} ${HistoryFields.textType},
          ${HistoryFields.name} ${HistoryFields.textType},
          ${HistoryFields.amount} ${HistoryFields.textType},
          ${HistoryFields.paymentMethod} ${HistoryFields.textType},
          ${HistoryFields.dueDay} ${HistoryFields.textType},
          ${HistoryFields.isVariableAmount} ${HistoryFields.textType},
          ${HistoryFields.paymentDateTime} ${HistoryFields.textType}
        )
      ''');
  }

  Future<void> save(HistoryModel payment) async {
    final db = await instance.database;
    await db.insert(HistoryFields.tableName, payment.toJson());
  }

  Future<List<HistoryModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(HistoryFields.tableName);
    final List<HistoryModel> listResult = result
        .map((json) => HistoryModel.fromJson(json))
        .toList();
    final List<HistoryModel> sortedList = listResult
      ..sort((a, b) => b.paymentDateTime!.compareTo(a.paymentDateTime!));
    return sortedList;
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

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
