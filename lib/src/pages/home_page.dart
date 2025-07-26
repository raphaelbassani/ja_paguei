import 'package:flutter/material.dart';

import '../../ui.dart';
import '../helpers/extensions.dart';
import '../helpers/routes.dart';
import '../widgets/bills_tab_widget.dart';
import '../widgets/history_tab_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  final List<Widget> tabPages = [
    BillsTabWidget(),
    HistoryTabWidget(),
    _BaseScreenWidget(title: 'Balanço'),
  ];

  final List<String> tabTitle = ['Contas', 'Histórico', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(title: tabTitle[tabIndex]),
      floatingActionButton: tabIndex == 0
          ? JPFab(label: 'Conta', onTap: () => context.pushNamed(Routes.bill))
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Contas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Balanço',
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
  final String title;

  const _BaseScreenWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(slivers: []);
  }
}
