import 'package:flutter/material.dart';
import 'package:ja_paguei/src/helpers/bills_database.dart';
import 'package:ja_paguei/src/helpers/routes.dart';
import 'package:ja_paguei/src/pages/home_page.dart';
import 'package:ja_paguei/src/pages/new_bill_page.dart';
import 'package:ja_paguei/src/view_models/database_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  BillsDatabase billsDatabase = BillsDatabase.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataBaseViewModel(billsDatabase)),
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
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataBaseViewModel>().refreshNotes();
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
      themeMode: themeMode,
      title: 'Já Paguei',
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.newBill: (context) => const NewBillPage(),
      },
    );
  }
}
