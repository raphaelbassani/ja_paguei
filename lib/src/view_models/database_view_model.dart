import '../enums/loading_status_enum.dart';
import '../helpers/bills_database.dart';
import '../helpers/payment_history_database.dart';
import '../models/bill_model.dart';
import 'view_model.dart';

class DataBaseViewModel extends ViewModel {
  final BillsDatabase billsDatabase;
  final PaymentHistoryDatabase paymentHistoryDatabase;

  DataBaseViewModel({
    required this.billsDatabase,
    required this.paymentHistoryDatabase,
  });

  StatusEnum status = StatusEnum.idle;
  List<BillModel> bills = [];

  void refreshBills() async {
    status = StatusEnum.loading;
    safeNotify();
    await billsDatabase.readAll().then((value) {
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

    billsDatabase.create(bill);
    refreshBills();
    return true;
  }

  void updateBill(BillModel bill) {
    billsDatabase.update(bill);
    refreshBills();
  }

  void deleteBill(BillModel bill) {
    billsDatabase.delete(bill.id!);
    refreshBills();
  }

  ///PaymentHistory Database

  List<BillModel> payments = [];

  void refreshHistory() async {
    status = StatusEnum.loading;
    safeNotify();
    await paymentHistoryDatabase.readAll().then((value) {
      payments = value;
    });
    status = StatusEnum.loaded;
    safeNotify();
  }

  bool createPayment(BillModel bill) {
    paymentHistoryDatabase.create(bill);
    refreshHistory();
    return true;
  }

  void deletePayment(BillModel bill) {
    paymentHistoryDatabase.delete(bill.id!);
    refreshHistory();
  }
}
