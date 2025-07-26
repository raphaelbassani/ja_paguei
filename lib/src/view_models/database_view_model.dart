import 'package:flutter/material.dart';

import '../enums/bill_status.dart';
import '../enums/loading_status_enum.dart';
import '../helpers/bills_database.dart';
import '../helpers/payments_history_database.dart';
import '../models/bill_model.dart';
import 'view_model.dart';

class DataBaseViewModel extends ViewModel {
  final BillsDatabase _billsDatabase;
  final PaymentsHistoryDatabase _paymentsHistoryDatabase;

  DataBaseViewModel({
    required BillsDatabase billsDatabase,
    required PaymentsHistoryDatabase paymentHistoryDatabase,
  }) : _paymentsHistoryDatabase = paymentHistoryDatabase,
       _billsDatabase = billsDatabase;

  StatusEnum status = StatusEnum.idle;
  List<BillModel> bills = [];

  void refreshBills() async {
    status = StatusEnum.loading;
    safeNotify();
    await _billsDatabase.readAll().then((savedBills) {
      _resetBillIfNeeded(savedBills);
    });
    status = StatusEnum.loaded;
    safeNotify();
  }

  void _resetBillIfNeeded(List<BillModel> savedBills) {
    List<BillModel> updatedBills = [];

    for (BillModel bill in savedBills) {
      BillModel? newBill;
      DateTime now = DateUtils.dateOnly(DateTime.now());

      if (bill.paymentDateTime != null) {
        if (now.isAfter(bill.paymentDateTime!.add(Duration(days: 20)))) {
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

    _billsDatabase.create(bill);
    refreshBills();
    return true;
  }

  void updateBill(BillModel bill) {
    _billsDatabase.update(bill);
    refreshBills();
  }

  void deleteBill(BillModel bill) {
    _billsDatabase.delete(bill.id!);
    refreshBills();
  }

  ///PaymentHistory Database

  List<BillModel> payments = [];

  void refreshHistory() async {
    status = StatusEnum.loading;
    safeNotify();
    await _paymentsHistoryDatabase.readAll().then((value) {
      payments = value;
    });
    status = StatusEnum.loaded;
    safeNotify();
  }

  bool createPayment(BillModel bill) {
    _paymentsHistoryDatabase.create(bill.copyWithNullId());
    refreshHistory();
    return true;
  }

  void deletePayment(BillModel bill) {
    _paymentsHistoryDatabase.delete(bill.id!);
    refreshHistory();
  }
}
