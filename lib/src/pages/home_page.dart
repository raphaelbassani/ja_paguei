import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../ui.dart';
import '../helpers/extensions.dart';
import '../helpers/routes.dart';
import '../widgets/home_tabs/balance_tab_widget.dart';
import '../widgets/home_tabs/bills_tab_widget.dart';
import '../widgets/home_tabs/history_tab_widget.dart';
import '../widgets/home_tabs/settings_tab_widget.dart';

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
    BalanceTabWidget(),
    SettingsTabWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> tabTitle = [
      context.translate(JPLocaleKeys.homeAccountTab),
      context.translate(JPLocaleKeys.homeHistoryTab),
      context.translate(JPLocaleKeys.homeBalanceTab),
      context.translate(JPLocaleKeys.homeSettingsTab),
    ];

    return Scaffold(
      appBar: JPAppBar(title: tabTitle[tabIndex]),
      floatingActionButton: tabIndex == 0
          ? JPFab(
              label: context.translate(JPLocaleKeys.homeAccount),
              onTap: () => context.pushNamed(Routes.bill),
            )
          : null,
      bottomNavigationBar: StylishBottomBar(
        currentIndex: tabIndex,
        onTap: onTabTapped,
        option: AnimatedBarOptions(iconStyle: IconStyle.animated),
        backgroundColor: context.backgroundColor,
        items: [
          BottomBarItem(
            icon: Icon(Icons.credit_card),
            title: JPText(tabTitle[0], color: Colors.green),
          ),
          BottomBarItem(
            icon: Icon(Icons.history),
            title: JPText(tabTitle[1], color: Colors.green),
          ),
          BottomBarItem(
            icon: Icon(Icons.attach_money),
            title: JPText(tabTitle[2], color: Colors.green),
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: JPText(tabTitle[3], color: Colors.green),
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
