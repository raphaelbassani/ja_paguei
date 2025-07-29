import 'package:flutter/material.dart';

import '../enums/bill_status_enum.dart';
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

    await _loadPaymentHistory();
    await _loadBills();

    status = StatusEnum.loaded;
    safeNotify();
  }

  Future<void> _loadPaymentHistory() async {
    await _paymentHistoryDatabase.readAll().then((value) {
      paymentHistory = value;
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

      if (bill.paymentDateTime != null) {
        PaymentHistoryModel lastBillPayment = paymentHistory.firstWhere(
          (e) => e.billId == bill.id,
        );

        if (now.isAfter(
              lastBillPayment.paymentDateTime!.add(Duration(days: 20)),
            ) &&
            bill.isPaid) {
          newBill = bill.copyWithCleaningPayment();
        }

        if (now.isAfter(lastBillPayment.paymentDateTime!) && bill.isNotPaid) {
          newBill = bill.copyWith(status: BillStatusEnum.overdue);
        }
      } else {
        if (now.isAfter(DateTime(now.year, now.month, bill.dueDay)) &&
            bill.isNotPaid) {
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

  bool savePaymentIntoHistory(BillModel bill) {
    _paymentHistoryDatabase.save(bill.toPaymentHistoryModel);
    loadData();
    return true;
  }
}
