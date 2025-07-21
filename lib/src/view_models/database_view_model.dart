import 'package:flutter/material.dart';
import 'package:ja_paguei/src/enums/loading_status_enum.dart';
import 'package:ja_paguei/src/helpers/bills_database.dart';
import 'package:ja_paguei/src/models/bill_model.dart';

class DataBaseViewModel with ChangeNotifier {
  final BillsDatabase billsDatabase;

  DataBaseViewModel(this.billsDatabase);

  StatusEnum status = StatusEnum.idle;
  List<BillModel> bills = [];

  refreshNotes() async {
    status = StatusEnum.loading;
    notifyListeners();
    await billsDatabase.readAll().then((value) {
      bills = value;
    });
    status = StatusEnum.loaded;
    notifyListeners();
  }
}
