import '../enums/loading_status_enum.dart';
import '../helpers/bills_database.dart';
import '../helpers/payment_history_database.dart';
import '../models/bill_model.dart';
import 'view_model.dart';

class DataBaseViewModel extends ViewModel {
  final BillsDatabase _billsDatabase;
  final PaymentHistoryDatabase _paymentHistoryDatabase;

  DataBaseViewModel({
    required BillsDatabase billsDatabase,
    required PaymentHistoryDatabase paymentHistoryDatabase,
  }) : _paymentHistoryDatabase = paymentHistoryDatabase,
       _billsDatabase = billsDatabase;

  StatusEnum status = StatusEnum.idle;
  List<BillModel> bills = [];

  void refreshBills() async {
    status = StatusEnum.loading;
    safeNotify();
    await _billsDatabase.readAll().then((value) {
      bills = value;
    });
    status = StatusEnum.loaded;
    safeNotify();
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
    await _paymentHistoryDatabase.readAll().then((value) {
      payments = value;
    });
    status = StatusEnum.loaded;
    safeNotify();
  }

  bool createPayment(BillModel bill) {
    _paymentHistoryDatabase.create(bill.copyWithNullId());
    refreshHistory();
    return true;
  }

  void deletePayment(BillModel bill) {
    _paymentHistoryDatabase.delete(bill.id!);
    refreshHistory();
  }
}
