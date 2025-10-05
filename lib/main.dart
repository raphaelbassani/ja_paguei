import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'core/extensions.dart';
import 'core/ui/components.dart';
import 'data/datasources.dart';
import 'l10n/l10n.dart';
import 'presentation/pages.dart';
import 'presentation/view_models.dart';
import 'routes.dart';

void main() {
  final BillDatabase billDatabase = BillDatabase.instance;
  final HistoryDatabase historyDatabase = HistoryDatabase.instance;

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
        ChangeNotifierProvider(create: (_) => LocaleViewModel()),
        Provider(create: (_) => JokeDatasource()),
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
      context.read<DataBaseViewModel>().setIsMock(true);

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
        Routes.splash: (context) => const SplashScreenPage(),
        Routes.home: (context) => LoaderOverlay(
          disableBackButton: true,
          overlayColor: context.backgroundColor.withAlpha(150),
          overlayWidgetBuilder: (_) => const JPLoaderOverlay(),
          child: const HomePage(),
        ),
        Routes.bill: (context) => const BillPage(),
        Routes.billVariableAmount: (context) => const BillVariableAmountPage(),
        Routes.billPaymentDate: (context) => const BillPaymentDatePage(),
      },
    );
  }
}
