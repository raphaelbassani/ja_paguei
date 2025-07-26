import 'package:flutter/material.dart';

import '../enums/bill_status.dart';
import '../enums/loading_status_enum.dart';
import '../helpers/bill_database.dart';
import '../helpers/payment_history_database.dart';
import '../models/bill_model.dart';
import '../models/payment_history_model.dart';
import 'view_model.dart';

class DataBaseViewModel extends ViewModel {
  final PaymentHistoryDatabase _paymentHistoryDatabase;
  final BillDatabase _billDatabase;

  DataBaseViewModel({
    required PaymentHistoryDatabase paymentHistoryDatabase,
    required BillDatabase billDatabase,
  }) : _paymentHistoryDatabase = paymentHistoryDatabase,
       _billDatabase = billDatabase;

  StatusEnum status = StatusEnum.idle;
  List<PaymentHistoryModel> paymentHistory = [];
  List<BillModel> bills = [];

  Future<void> loadData() async {
    status = StatusEnum.loading;
    safeNotify();

    await _refreshPaymentHistory();
    await _refreshBills();

    status = StatusEnum.loaded;
    safeNotify();
  }

  Future<void> _refreshPaymentHistory() async {
    await _paymentHistoryDatabase.readAll().then((value) {
      paymentHistory = value;
    });
  }

  Future<void> _refreshBills() async {
    await _billDatabase.readAll().then((savedBills) {
      _resetBillIfNeeded(savedBills);
    });
  }

  void _resetBillIfNeeded(List<BillModel> savedBills) {
    List<BillModel> updatedBills = [];

    for (BillModel bill in savedBills) {
      BillModel? newBill;
      DateTime now = DateUtils.dateOnly(DateTime.now());

      if (bill.paymentDateTime != null) {
        if (now.isAfter(bill.paymentDateTime!.add(Duration(days: 20))) &&
            bill.isPayed) {
          newBill = bill.copyWithCleaningPayment();
        }

        if (now.isAfter(bill.paymentDateTime!) && bill.isNotPayed) {
          newBill = bill.copyWith(status: BillStatusEnum.overdue);
        }
      } else {
        if (now.isAfter(DateTime(now.year, now.month, bill.dueDay)) &&
            bill.isNotPayed) {
          newBill = bill.copyWith(status: BillStatusEnum.overdue);
        }
      }

      updatedBills.add(newBill ?? bill);
    }

    bills = updatedBills;
  }

  bool createBill(BillModel bill) {
    bool hasAnyWithTheSameName = bills.any((e) => e.name == bill.name);
    if (hasAnyWithTheSameName) {
      return false;
    }

    _billDatabase.create(bill);
    _refreshBills();
    return true;
  }

  void updateBill(BillModel bill) {
    _billDatabase.update(bill);
    _refreshBills();
  }

  void deleteBill(BillModel bill) {
    _billDatabase.delete(bill.id!);
    _refreshBills();
  }

  bool savePaymentIntoHistory(BillModel bill) {
    _paymentHistoryDatabase.save(bill.toPaymentHistoryModel);
    _refreshPaymentHistory();
    return true;
  }
}
