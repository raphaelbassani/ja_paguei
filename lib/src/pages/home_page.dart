import 'package:flutter/material.dart';
import 'package:ja_paguei/src/helpers/navigator_extension.dart';
import 'package:ja_paguei/src/helpers/routes.dart';
import 'package:ja_paguei/src/widgets/bills_tab_widget.dart';

import '../../ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  final List<Widget> tabPages = [
    BillsTabWidget(),
    _BaseScreenWidget(title: 'Meus pedidos'),
    _BaseScreenWidget(title: 'Balanço'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(title: 'Já Paguei'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(Routes.newBill),
      ),
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
