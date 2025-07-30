import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/ui/ui.dart';
import '../../../l10n/l10n.dart';
import '../../state/view_models.dart';

class SettingsTabWidget extends StatelessWidget {
  const SettingsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: JPPadding.all,
            child: Column(
              children: [
                const _SettingThemeModeContainerWidget(),
                JPSpacingVertical.m,
                const _SettingLanguageContainerWidget(),
                JPSpacingVertical.m,
                const _SettingDeleteAllDataContainerWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingThemeModeContainerWidget extends StatelessWidget {
  const _SettingThemeModeContainerWidget();

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel themeViewModel = context.watch<ThemeViewModel>();

    return _SettingContainerWidget(
      label: context.translate(JPLocaleKeys.settingsDarkMode),
      icon: Icons.dark_mode,
      onTap: () => onTap(themeViewModel),
      trailingWidget: Switch(
        value: themeViewModel.isDarkMode,
        onChanged: (_) => onTap(themeViewModel),
        activeColor: Colors.green,
      ),
    );
  }

  void onTap(ThemeViewModel themeViewModel) {
    if (themeViewModel.isLightMode) {
      themeViewModel.changeToDarkTheme();
    } else {
      themeViewModel.changeToLightTheme();
    }
  }
}

class _SettingLanguageContainerWidget extends StatelessWidget {
  const _SettingLanguageContainerWidget();

  @override
  Widget build(BuildContext context) {
    final LocaleViewModel localeViewModel = context.watch<LocaleViewModel>();

    return _SettingContainerWidget(
      label: context.translate(JPLocaleKeys.settingsLanguage),
      icon: Icons.language,
      onTap: () => onTap(context: context, localeViewModel: localeViewModel),
      trailingWidget: Column(
        children: [
          JPSpacingVertical.s,
          const Icon(Icons.chevron_right),
          JPSpacingVertical.s,
        ],
      ),
    );
  }

  void onTap({
    required BuildContext context,
    required LocaleViewModel localeViewModel,
  }) {
    List<String> items = [
      context.translate(JPLocaleKeys.en),
      context.translate(JPLocaleKeys.pt),
    ];

    context.showModal(
      child: JPSelectionModal(
        title: context.translate(JPLocaleKeys.settingsSelectLanguage),
        items: items,
        preSelectedValue:
            localeViewModel.appLocale?.languageCode == JPLocaleKeys.en
            ? items.first
            : items[1],
        primaryButtonLabel: context.translate(JPLocaleKeys.confirm),
        onTapPrimaryButton: (value) {
          if (value == items.first) {
            localeViewModel.changeLang(const Locale(JPLocaleKeys.en));
          } else {
            localeViewModel.changeLang(const Locale(JPLocaleKeys.pt));
          }
        },
      ),
    );
  }
}

class _SettingDeleteAllDataContainerWidget extends StatelessWidget {
  const _SettingDeleteAllDataContainerWidget();

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return _SettingContainerWidget(
      label: context.translate(JPLocaleKeys.settingsDeleteAllData),
      icon: Icons.folder_copy_rounded,
      onTap: () =>
          onTap(context: context, dataBaseViewModel: dataBaseViewModel),
      trailingWidget: Column(
        children: [
          JPSpacingVertical.s,
          const Icon(Icons.chevron_right),
          JPSpacingVertical.s,
        ],
      ),
    );
  }

  void onTap({
    required BuildContext context,
    required DataBaseViewModel dataBaseViewModel,
  }) {
    context.showModal(
      child: JPConfirmationModal(
        title: context.translate(JPLocaleKeys.settingsDeleteAllDataModal),
        primaryButtonLabel: context.translate(JPLocaleKeys.confirm),
        onTapPrimaryButton: () {
          dataBaseViewModel.deleteAllDatabasesData();
          context.pop();
          context.showSnackInfo(
            context.translate(JPLocaleKeys.settingsDeleteAllDataSnack),
          );
        },
      ),
    );
  }
}

class _SettingContainerWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailingWidget;
  final Function() onTap;

  const _SettingContainerWidget({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: JPGestureDetector(
        onTap: onTap,
        child: Padding(
          padding: JPPadding.horizontal,
          child: Column(
            children: [
              JPSpacingVertical.xxs,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.green,
                    child: Icon(icon, color: context.backgroundColor),
                  ),
                  JPSpacingHorizontal.s,
                  JPText(label),
                  const Spacer(),
                  trailingWidget,
                ],
              ),
              JPSpacingVertical.xxs,
            ],
          ),
        ),
      ),
    );
  }
}
