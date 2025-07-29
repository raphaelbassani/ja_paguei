import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'src/helpers/bill_database.dart';
import 'src/helpers/history_database.dart';
import 'src/helpers/routes.dart';
import 'src/pages/bill_page.dart';
import 'src/pages/bill_payment_date_page.dart';
import 'src/pages/bill_variable_amount_page.dart';
import 'src/pages/home_page.dart';
import 'src/view_models/database_view_model.dart';
import 'src/view_models/locale_view_model.dart';
import 'src/view_models/theme_view_model.dart';
import 'ui.dart';

void main() {
  BillDatabase billDatabase = BillDatabase.instance;
  HistoryDatabase historyDatabase = HistoryDatabase.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataBaseViewModel(
            billDatabase: billDatabase,
            historyDatabase: historyDatabase,
          ),
        ),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (context) => LocaleViewModel()),
      ],
      child: JaPagueiApp(
        billDatabase: billDatabase,
        historyDatabase: historyDatabase,
      ),
    ),
  );
}

class JaPagueiApp extends StatefulWidget {
  final BillDatabase billDatabase;
  final HistoryDatabase historyDatabase;

  const JaPagueiApp({
    required this.billDatabase,
    required this.historyDatabase,
    super.key,
  });

  @override
  State<JaPagueiApp> createState() => _JaPagueiAppState();
}

class _JaPagueiAppState extends State<JaPagueiApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DataBaseViewModel>().loadData();
      context.read<ThemeViewModel>().loadTheme();
      context.read<LocaleViewModel>().loadLang();
    });
  }

  @override
  dispose() {
    widget.billDatabase.close();
    widget.historyDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: context.watch<ThemeViewModel>().currentTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: JPLocale.supportedLocales,
      locale: context.watch<LocaleViewModel>().appLocale,
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.bill: (context) => const BillPage(),
        Routes.billVariableAmount: (context) => const BillVariableAmountPage(),
        Routes.billPaymentDate: (context) => const BillPaymentDatePage(),
      },
    );
  }
}
