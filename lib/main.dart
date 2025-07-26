import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'src/helpers/bills_database.dart';
import 'src/helpers/payment_history_database.dart';
import 'src/helpers/routes.dart';
import 'src/pages/bill_page.dart';
import 'src/pages/bill_payment_date_page.dart';
import 'src/pages/bill_variable_value_page.dart';
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
      child: JaPagueiApp(
        billsDatabase: billsDatabase,
        paymentHistoryDatabase: paymentHistoryDatabase,
      ),
    ),
  );
}

class JaPagueiApp extends StatefulWidget {
  final BillsDatabase billsDatabase;
  final PaymentHistoryDatabase paymentHistoryDatabase;

  const JaPagueiApp({
    required this.billsDatabase,
    required this.paymentHistoryDatabase,
    super.key,
  });

  @override
  State<JaPagueiApp> createState() => _JaPagueiAppState();
}

class _JaPagueiAppState extends State<JaPagueiApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataBaseViewModel>().loadData();
    });
  }

  @override
  dispose() {
    widget.billsDatabase.close();
    widget.paymentHistoryDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Já Paguei',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: context.watch<ThemeViewModel>().currentTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('pt', 'BR'), // Portuguese (Brazil)
      ],
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.bill: (context) => const BillPage(),
        Routes.billVariableValue: (context) => const BillVariableValuePage(),
        Routes.billPaymentDate: (context) => const BillPaymentDatePage(),
      },
    );
  }
}
