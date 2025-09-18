import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/datasources.dart';
import '../../data/models.dart';
import '../../l10n/l10n.dart';
import '../enums/bill_status_enum.dart';
import '../enums/status_enum.dart';
import 'base_view_model.dart';

class DataBaseViewModel extends BaseViewModel {
  final HistoryDatabase _historyDatabase;
  final BillDatabase _billDatabase;

  DataBaseViewModel({
    required HistoryDatabase historyDatabase,
    required BillDatabase billDatabase,
  }) : _historyDatabase = historyDatabase,
       _billDatabase = billDatabase;

  StatusEnum get status => _status;

  List<HistoryModel> get history => _history;

  List<BillModel> get bills => _bills;

  StatusEnum _status = StatusEnum.idle;
  List<HistoryModel> _history = [];
  List<BillModel> _bills = [];

  Future<void> loadData() async {
    _status = StatusEnum.loading;
    safeNotify();

    await _loadHistory();
    await _loadBills();

    _status = StatusEnum.loaded;
    safeNotify();
  }

  Future<void> _loadHistory() async {
    await _historyDatabase.readAll().then((value) {
      _history = value;
    });
  }

  Future<void> _loadBills() async {
    await _billDatabase.readAll().then((savedBills) {
      _resetBillIfNeeded(savedBills);
    });
  }

  void _resetBillIfNeeded(List<BillModel> savedBills) {
    List<BillModel> updatedBills = [];

    for (BillModel bill in savedBills) {
      BillModel? newBill;
      DateTime now = DateUtils.dateOnly(DateTime.now());

      if (bill.paymentDateTime != null && _history.isNotEmpty) {
        HistoryModel? lastBillPayment = _history.firstWhereOrNull(
          (e) => e.billId == bill.id,
        );

        if (lastBillPayment != null) {
          if (now.isAfter(
                lastBillPayment.paymentDateTime!.add(const Duration(days: 20)),
              ) &&
              bill.isPaid) {
            newBill = bill.copyWithCleaningPayment();
          }

          if (now.isAfter(lastBillPayment.paymentDateTime!) && bill.isNotPaid) {
            newBill = bill.copyWith(status: BillStatusEnum.overdue);
          }
        }
      } else {
        final DateTime nextPaymentDate = DateTime(
          now.year,
          now.month,
          bill.dueDay,
        );
        if (now.isAfter(nextPaymentDate) &&
            bill.isNotPaid &&
            bill.createdAt!.isBefore(nextPaymentDate)) {
          newBill = bill.copyWith(status: BillStatusEnum.overdue);
        }
      }

      updatedBills.add(newBill ?? bill);
    }

    _bills = updatedBills;
  }

  bool createBill(BillModel bill) {
    bool hasAnyWithTheSameName = _bills.any((e) => e.name == bill.name);
    if (hasAnyWithTheSameName) {
      return false;
    }

    _billDatabase.create(bill);
    loadData();
    return true;
  }

  void updateBill(BillModel bill) {
    _billDatabase.update(bill);
    loadData();
  }

  void deleteBill(BillModel bill) {
    _billDatabase.delete(bill.id!);
    loadData();
  }

  void savePaymentIntoHistory(BillModel bill) {
    _historyDatabase.save(bill.toHistoryModel);
    loadData();
  }

  void deletePaymentOfHistory(HistoryModel payment) {
    _historyDatabase.delete(payment.id!);
    loadData();
  }

  void deleteAllDatabasesData() {
    _historyDatabase.deleteAllRows();
    _billDatabase.deleteAllRows();
    loadData();
  }

  bool hasAlreadyPaidBillOnSameDateHistory(BillModel bill) {
    return _history.any(
      (e) => e.billId == bill.id && e.paymentDateTime == bill.paymentDateTime,
    );
  }

  Map<String, List<double>> balanceGraphItems({int maxNumberOfBars = 6}) {
    Map<String, List<double>> graphItems = {};

    if (_history.isEmpty) {
      return {};
    }

    final List<HistoryModel> ascHistory = _history;

    ascHistory.sort((b, a) => b.paymentDateTime!.compareTo(a.paymentDateTime!));

    int barCount = 0;
    int currentMonth = ascHistory.first.paymentDateTime!.month;
    List<double> values = [];
    for (var item in ascHistory) {
      final int itemMonth = item.paymentDateTime!.month;

      if (currentMonth != itemMonth) {
        Map<String, List<double>> newItem = {_months[currentMonth]!: values};
        graphItems.addAll(newItem);
        barCount++;

        if (barCount == maxNumberOfBars) {
          return graphItems;
        }

        currentMonth = itemMonth;
        values = [];
      }

      values.add(item.amount);
    }

    Map<String, List<double>> newItem = {_months[currentMonth]!: values};
    graphItems.addAll(newItem);

    return graphItems;
  }

  Future<XFile> exportAndShareJson() async {
    List<Map<String, dynamic>> billJson = await _billDatabase.exportAsJson();
    List<Map<String, dynamic>> historyJson = await _historyDatabase
        .exportAsJson();

    Map<String, dynamic> json = {'bill': billJson, 'history': historyJson};

    String jsonString = jsonEncode(json);

    late final Directory directory;
    if (Platform.isAndroid) {
      directory = await getTemporaryDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final path = '${directory.path}/data.json';
    final file = File(path);
    await file.writeAsString(jsonString);

    return XFile(file.path);
  }

  Future<void> importFromJson(String jsonString) async {
    await _historyDatabase.deleteAllRows();
    await _billDatabase.deleteAllRows();

    Map<String, dynamic> data = jsonDecode(jsonString);

    List<dynamic> billData = data['bill'];
    List<dynamic> historyData = data['history'];

    await _billDatabase.importFromJson(billData);
    await _historyDatabase.importFromJson(historyData);

    loadData();
  }

  final Map<int, String> _months = {
    1: JPLocaleKeys.jan,
    2: JPLocaleKeys.feb,
    3: JPLocaleKeys.mar,
    4: JPLocaleKeys.apr,
    5: JPLocaleKeys.may,
    6: JPLocaleKeys.jun,
    7: JPLocaleKeys.jul,
    8: JPLocaleKeys.aug,
    9: JPLocaleKeys.sep,
    10: JPLocaleKeys.oct,
    11: JPLocaleKeys.nov,
    12: JPLocaleKeys.dec,
  };
}
