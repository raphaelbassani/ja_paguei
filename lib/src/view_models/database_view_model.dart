import '../enums/loading_status_enum.dart';
import '../helpers/bills_database.dart';
import '../models/bill_model.dart';
import 'view_model.dart';

class DataBaseViewModel extends ViewModel {
  final BillsDatabase billsDatabase;

  DataBaseViewModel(this.billsDatabase);

  StatusEnum status = StatusEnum.idle;
  List<BillModel> bills = [];

  refreshNotes() async {
    status = StatusEnum.loading;
    safeNotify();
    await billsDatabase.readAll().then((value) {
      bills = value;
    });
    status = StatusEnum.loaded;
    safeNotify();
  }

  createBill(BillModel bill) {
    billsDatabase.create(bill);
    refreshNotes();
  }

  updateBill(BillModel bill) {
    billsDatabase.update(bill);
    refreshNotes();
  }

  deleteBill(BillModel bill) {
    billsDatabase.delete(bill.id!);
    refreshNotes();
  }
}
