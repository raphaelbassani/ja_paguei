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
