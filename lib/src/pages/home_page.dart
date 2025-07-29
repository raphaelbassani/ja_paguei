import 'package:flutter/material.dart';

import '../../ui.dart';
import '../helpers/extensions.dart';
import '../helpers/routes.dart';
import '../widgets/home_tabs/bills_tab_widget.dart';
import '../widgets/home_tabs/payment_history_tab_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  final List<Widget> tabPages = [
    BillsTabWidget(),
    PaymentHistoryTabWidget(),
    _BaseScreenWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> tabTitle = [
      context.translate(JPLocaleKeys.homeAccountTab),
      context.translate(JPLocaleKeys.homeHistoryTab),
      context.translate(JPLocaleKeys.homeBalanceTab),
    ];

    return Scaffold(
      appBar: JPAppBar(title: tabTitle[tabIndex]),
      floatingActionButton: tabIndex == 0
          ? JPFab(
              label: context.translate(JPLocaleKeys.homeAccount),
              onTap: () => context.pushNamed(Routes.bill),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: tabTitle[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: tabTitle[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: tabTitle[2],
          ),
        ],
      ),
      body: tabPages[tabIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      tabIndex = index;
    });
  }
}

class _BaseScreenWidget extends StatelessWidget {
  const _BaseScreenWidget();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(slivers: []);
  }
}
