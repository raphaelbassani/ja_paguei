import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../core/extensions.dart';
import '../../core/ui.dart';
import '../../l10n/jp_locale_keys.dart';
import '../../routes.dart';
import '../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabPages = [
      const BillsTabWidget(),
      const HistoryTabWidget(),
      const BalanceTabWidget(),
      const SettingsTabWidget(),
    ];

    final List<String> tabTitle = [
      context.translate(JPLocaleKeys.homeAccountTab),
      context.translate(JPLocaleKeys.homeHistoryTab),
      context.translate(JPLocaleKeys.homeBalanceTab),
      context.translate(JPLocaleKeys.homeSettingsTab),
    ];

    return PopScope(
      canPop: false,
      child: context.isIos
          ? _IosHomePage(
              tabIndex: tabIndex,
              tabPages: tabPages,
              tabTitle: tabTitle,
              onTabTapped: onTabTapped,
            )
          : _AndroidHomePage(
              tabIndex: tabIndex,
              tabPages: tabPages,
              tabTitle: tabTitle,
              onTabTapped: onTabTapped,
            ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      tabIndex = index;
    });
  }
}

class _IosHomePage extends StatefulWidget {
  final int tabIndex;
  final List<Widget> tabPages;
  final List<String> tabTitle;
  final Function(int) onTabTapped;

  const _IosHomePage({
    required this.tabIndex,
    required this.tabPages,
    required this.tabTitle,
    required this.onTabTapped,
  });

  @override
  State<_IosHomePage> createState() => _IosHomePageState();
}

class _IosHomePageState extends State<_IosHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      final i = _controller.index;
      if (i != widget.tabIndex) {
        widget.onTabTapped(i);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Content below
          SafeArea(
            child: Positioned.fill(
              child: Padding(
                padding: JPPadding.top,
                child: TabBarView(
                  controller: _controller,
                  children: widget.tabPages,
                ),
              ),
            ),
          ),
          // Native tab bar overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: CNTabBar(
              tint: Colors.green,
              items: [
                CNTabBarItem(
                  label: widget.tabTitle[0],
                  icon: const CNSymbol('creditcard'),
                ),
                CNTabBarItem(
                  label: widget.tabTitle[1],
                  icon: const CNSymbol('clock'),
                ),
                CNTabBarItem(
                  label: widget.tabTitle[2],
                  icon: const CNSymbol('dollarsign.circle'),
                ),
                CNTabBarItem(
                  label: widget.tabTitle[3],
                  icon: const CNSymbol('gearshape'),
                ),
              ],
              currentIndex: widget.tabIndex,
              split: false,
              shrinkCentered: true,
              onTap: (i) {
                widget.onTabTapped(i);
                _controller.animateTo(i);
              },
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: CNButton.icon(
                icon: const CNSymbol('plus.circle', size: 18),
                onPressed: () => context.pushNamed(Routes.bill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AndroidHomePage extends StatelessWidget {
  final int tabIndex;
  final List<Widget> tabPages;
  final List<String> tabTitle;
  final Function(int) onTabTapped;

  const _AndroidHomePage({
    required this.tabIndex,
    required this.tabPages,
    required this.tabTitle,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
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
}
