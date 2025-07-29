import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/widgets/jp_primary_button.dart';
import '../../view_models/locale_view_model.dart';
import '../../view_models/theme_view_model.dart';

class SettingsTabWidget extends StatelessWidget {
  const SettingsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel themeViewModel = context.watch<ThemeViewModel>();
    final LocaleViewModel localeViewModel = context.watch<LocaleViewModel>();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: JPPrimaryButton(
            label: 'Trocar tema',
            onTap: () {
              if (themeViewModel.currentTheme == ThemeMode.dark) {
                themeViewModel.changeToLightTheme();
              } else {
                themeViewModel.changeToDarkTheme();
              }
            },
          ),
        ),
        SliverToBoxAdapter(
          child: JPPrimaryButton(
            label: 'Trocar lingua',
            onTap: () {
              if (localeViewModel.appLocale?.languageCode == 'us') {
                localeViewModel.changeLang(Locale('pt'));
              } else {
                localeViewModel.changeLang(Locale('us'));
              }
            },
          ),
        ),
      ],
    );
  }
}
