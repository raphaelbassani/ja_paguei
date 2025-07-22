import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/helpers/bills_database.dart';
import 'src/helpers/payment_history_database.dart';
import 'src/helpers/routes.dart';
import 'src/pages/bill_page.dart';
import 'src/pages/home_page.dart';
import 'src/view_models/database_view_model.dart';
import 'src/view_models/theme_view_model.dart';

void main() {
  BillsDatabase billsDatabase = BillsDatabase.instance;
  PaymentHistoryDatabase paymentHistoryDatabase =
      PaymentHistoryDatabase.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataBaseViewModel(
            billsDatabase: billsDatabase,
            paymentHistoryDatabase: paymentHistoryDatabase,
          ),
        ),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: MyApp(billsDatabase: billsDatabase),
    ),
  );
}

class MyApp extends StatefulWidget {
  final BillsDatabase billsDatabase;

  const MyApp({required this.billsDatabase, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataBaseViewModel>().refreshBills();
    });

    super.initState();
  }

  @override
  dispose() {
    widget.billsDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: context.watch<ThemeViewModel>().currentTheme,
      title: 'Já Paguei',
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.bill: (context) => const BillPage(),
      },
    );
  }
}
