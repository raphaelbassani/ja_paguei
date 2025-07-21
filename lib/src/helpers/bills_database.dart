import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/bill_model.dart';

class BillsDatabase {
  static final BillsDatabase instance = BillsDatabase._internal();

  static Database? _database;

  BillsDatabase._internal();

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
          ${BillFields.value} ${BillFields.textType},
          ${BillFields.paymentMethod} ${BillFields.textType},
          ${BillFields.dueDay} ${BillFields.textType},
          ${BillFields.status} ${BillFields.textType},
          ${BillFields.isVariableValue} ${BillFields.textType},
          ${BillFields.paymentDateTime} ${BillFields.textType}
        )
      ''');
  }

  Future<BillModel> create(BillModel bill) async {
    final db = await instance.database;
    final id = await db.insert(BillFields.tableName, bill.toJson());
    return bill.copyWith(id: id);
  }

  Future<BillModel> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      BillFields.tableName,
      columns: BillFields.values,
      where: '${BillFields.id} = ?',
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
    const orderBy = '${BillFields.dueDay} ASC';
    final result = await db.query(BillFields.tableName, orderBy: orderBy);
    return result.map((json) => BillModel.fromJson(json)).toList();
  }

  Future<int> update(BillModel bill) async {
    final db = await instance.database;
    return db.update(
      BillFields.tableName,
      bill.toJson(),
      where: '${BillFields.id} = ?',
      whereArgs: [bill.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      BillFields.tableName,
      where: '${BillFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

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
