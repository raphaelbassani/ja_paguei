import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/bill_model.dart';

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
          ${PaymentHistoryFields.name} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.value} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.paymentMethod} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.dueDay} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.status} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.isVariableValue} ${PaymentHistoryFields.textType},
          ${PaymentHistoryFields.paymentDateTime} ${PaymentHistoryFields.textType}
        )
      ''');
  }

  Future<BillModel> create(BillModel bill) async {
    final db = await instance.database;
    final id = await db.insert(PaymentHistoryFields.tableName, bill.toJson());
    return bill.copyWith(id: id);
  }

  Future<BillModel> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      PaymentHistoryFields.tableName,
      columns: PaymentHistoryFields.values,
      where: '${PaymentHistoryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BillModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<BillModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(PaymentHistoryFields.tableName);
    final List<BillModel> listResult = result
        .map((json) => BillModel.fromJson(json))
        .toList();
    final List<BillModel> sortedList = listResult
      ..sort((a, b) => a.paymentDateTime!.compareTo(b.paymentDateTime!));
    return sortedList;
  }

  Future<int> update(BillModel bill) async {
    final db = await instance.database;
    return db.update(
      PaymentHistoryFields.tableName,
      bill.toJson(),
      where: '${PaymentHistoryFields.id} = ?',
      whereArgs: [bill.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      PaymentHistoryFields.tableName,
      where: '${PaymentHistoryFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class PaymentHistoryFields {
  static const String tableName = 'payment_history';
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
