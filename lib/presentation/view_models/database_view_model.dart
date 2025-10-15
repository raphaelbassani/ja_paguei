import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants.dart';
import '../../data/datasources.dart';
import '../../data/models.dart';
import '../enums.dart';
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

  bool isMock = false;

  void setIsMock(bool value) {
    isMock = value;
    safeNotify();
  }

  Future<void> loadData() async {
    _status = StatusEnum.loading;
    safeNotify();

    await _loadHistory();
    await _loadBills();

    _status = StatusEnum.loaded;
    safeNotify();
  }

  Future<void> _loadHistory() async {
    if (isMock) {
      _history = mockLoadHistory();
      return;
    }

    await _historyDatabase.readAll().then((value) {
      _history = value;
    });
  }

  Future<void> _loadBills() async {
    if (isMock) {
      _resetBillIfNeeded(mockLoadBills());
      return;
    }

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

  Map<String, List<double>> balanceGraphItems({int numberOfMonths = 6}) {
    Map<String, List<double>> graphItems = {};
    int currentMonth = DateTime.now().month;

    if (_history.isNotEmpty) {
      final List<HistoryModel> ascHistory = List.from(_history);
      ascHistory.sort(
        (b, a) => b.paymentDateTime!.compareTo(a.paymentDateTime!),
      );

      int barCount = 0;
      currentMonth = ascHistory.first.paymentDateTime!.month;
      int currentYear = ascHistory.first.paymentDateTime!.year;
      List<double> values = [];
      for (var item in ascHistory) {
        final int itemMonth = item.paymentDateTime!.month;
        final int itemYear = item.paymentDateTime!.year;

        if (currentMonth != itemMonth || currentYear != itemYear) {
          graphItems[LocalStorageConstants.months[currentMonth]!] = values;
          barCount++;

          if (barCount == numberOfMonths) {
            break;
          }

          currentMonth = itemMonth;
          currentYear = itemYear;
          values = [];
        }
        values.add(item.amount);
      }
      graphItems[LocalStorageConstants.months[currentMonth]!] = values;
    }

    while (graphItems.length < numberOfMonths) {
      currentMonth--;
      if (currentMonth == 0) {
        currentMonth = 12;
      }
      graphItems[LocalStorageConstants.months[currentMonth]!] = [];
    }

    final monthOrder = LocalStorageConstants.months.values.toList();
    final entries = graphItems.entries.toList();
    entries.sort(
      (a, b) => monthOrder.indexOf(a.key).compareTo(monthOrder.indexOf(b.key)),
    );
    final ordered = Map<String, List<double>>.fromEntries(
      entries.take(numberOfMonths),
    );

    return ordered;
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
}
