import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/models.dart';
import '../datasources.dart';

class BillDatabase {
  static final BillDatabase instance = BillDatabase._internal();

  static Database? _database;

  BillDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bills.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE ${BillFields.tableName} (
          ${BillFields.id} ${BillFields.idType},
          ${BillFields.name} ${BillFields.textType},
          ${BillFields.amount} ${BillFields.textType},
          ${BillFields.paymentMethod} ${BillFields.textType},
          ${BillFields.dueDay} ${BillFields.textType},
          ${BillFields.status} ${BillFields.textType},
          ${BillFields.isVariableAmount} ${BillFields.textType},
          ${BillFields.paymentDateTime} ${BillFields.textType},
          ${BillFields.createdAt} ${BillFields.textType}
        )
      ''');
  }

  Future<void> create(BillModel bill) async {
    final db = await instance.database;
    await db.insert(BillFields.tableName, bill.toJson());
  }

  Future<List<BillModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(BillFields.tableName);
    final List<BillModel> listResult = result
        .map((json) => BillModel.fromJson(json))
        .toList();
    final List<BillModel> sortedList = listResult
      ..sort((b, a) => b.dueDay.compareTo(a.dueDay));

    DateTime today = DateTime.now();
    final DateTime referenceDate = today.subtract(const Duration(days: 5));
    final int referenceDay = referenceDate.day;

    int index = sortedList.indexWhere((d) => d.dueDay >= referenceDay);
    if (index == -1) {
      index = 0;
    }

    final List<BillModel> orderDays = [
      ...sortedList.sublist(index),
      ...sortedList.sublist(0, index),
    ];

    return orderDays;
  }

  Future<void> update(BillModel bill) async {
    final db = await instance.database;
    db.update(
      BillFields.tableName,
      bill.toJson(),
      where: '${BillFields.id} = ?',
      whereArgs: [bill.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete(
      BillFields.tableName,
      where: '${BillFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllRows() async {
    final db = await database;
    await db.delete(BillFields.tableName);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
