import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../core/extensions.dart';
import '../../core/ui.dart';
import '../../l10n/l10n.dart';
import '../../routes.dart';
import '../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  final List<Widget> tabPages = [
    const BillsTabWidget(),
    const HistoryTabWidget(),
    const BalanceTabWidget(),
    const SettingsTabWidget(),
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
            icon: const Icon(Icons.credit_card),
            title: JPText(tabTitle[0], color: Colors.green),
          ),
          BottomBarItem(
            icon: const Icon(Icons.history),
            title: JPText(tabTitle[1], color: Colors.green),
          ),
          BottomBarItem(
            icon: const Icon(Icons.attach_money),
            title: JPText(tabTitle[2], color: Colors.green),
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings),
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
