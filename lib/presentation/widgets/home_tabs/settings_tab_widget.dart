import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/extensions.dart';
import '../../../core/ui.dart';
import '../../../data/datasources.dart';
import '../../../data/models/joke_model.dart';
import '../../../data/services.dart';
import '../../../l10n/l10n.dart';
import '../../view_models.dart';
import '../top_padding_widget.dart';

class SettingsTabWidget extends StatelessWidget {
  const SettingsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const TopPaddingWidget(),
        SliverToBoxAdapter(
          child: Padding(
            padding: JPPadding.all,
            child: Column(
              children: [
                const _SettingTellMeAJokeContainerWidget(),
                JPSpacingVertical.m,
                const _SettingThemeModeContainerWidget(),
                JPSpacingVertical.m,
                const _SettingLanguageContainerWidget(),
                JPSpacingVertical.m,
                const _SettingExportAllDataContainerWidget(),
                JPSpacingVertical.m,
                const _SettingImportAllDataContainerWidget(),
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
      onTap: () {},
      trailingWidget: JPSelectionSwitch(
        isSelected: themeViewModel.isDarkMode,
        onTap: (_) => onTap(themeViewModel),
      ),
    );
  }

  Future<void> onTap(ThemeViewModel themeViewModel) async {
    if (themeViewModel.isLightMode) {
      await themeViewModel.changeToDarkTheme();
    } else {
      await themeViewModel.changeToLightTheme();
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

class _SettingExportAllDataContainerWidget extends StatelessWidget {
  const _SettingExportAllDataContainerWidget();

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return _SettingContainerWidget(
      label: context.translate(JPLocaleKeys.settingsExportAllData),
      icon: Icons.folder_copy,
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

  void permissionSnackBar({required BuildContext context}) {
    if (context.mounted) {
      context.showSnackError(
        context.translate(JPLocaleKeys.settingsExportAllDataPermission),
      );
    }
  }

  Future<void> onTap({
    required BuildContext context,
    required DataBaseViewModel dataBaseViewModel,
  }) async {
    if (Platform.isAndroid) {
      await context.androidStoragePermission(
        permission: Permission.storage,
        noPermissionSnackBar: permissionSnackBar,
      );
    }

    if (context.mounted) {
      context.showLoader();
    }
    XFile file = await dataBaseViewModel.exportAndShareJson();
    if (context.mounted) {
      context.hideLoader();
    }

    if (Platform.isIOS && context.mounted) {
      final box = context.findRenderObject() as RenderBox?;
      await SharePlus.instance.share(
        ShareParams(
          files: [file],
          sharePositionOrigin: box != null
              ? Rect.fromLTWH(0, 0, box.size.width, box.size.height)
              : Rect.zero,
        ),
      );
      return;
    }

    await SharePlus.instance.share(ShareParams(files: [file]));
  }
}

class _SettingImportAllDataContainerWidget extends StatelessWidget {
  const _SettingImportAllDataContainerWidget();

  @override
  Widget build(BuildContext context) {
    final DataBaseViewModel dataBaseViewModel = context
        .watch<DataBaseViewModel>();

    return _SettingContainerWidget(
      label: context.translate(JPLocaleKeys.settingsImportAllData),
      icon: Icons.create_new_folder,
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

  void permissionSnackBar({required BuildContext context}) {
    if (context.mounted) {
      context.showSnackError(
        context.translate(JPLocaleKeys.settingsImportAllDataAccessError),
      );
    }
  }

  Future<void> onTap({
    required BuildContext context,
    required DataBaseViewModel dataBaseViewModel,
  }) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if ((result?.files == null || (result?.files.isEmpty ?? true)) &&
        context.mounted) {
      context.showSnackError(
        context.translate(JPLocaleKeys.settingsImportAllDataAccessError),
      );
      return;
    }
    String path = result!.files.first.path!;

    final file = File(path);
    final bool fileExists = await file.exists();

    if (!fileExists && context.mounted) {
      context.showSnackError(
        context.translate(JPLocaleKeys.settingsImportAllDataAccessError),
      );
      return;
    }

    try {
      String jsonString = await file.readAsString();

      if (context.mounted) {
        context.showLoader();
      }
      await dataBaseViewModel.importFromJson(jsonString);
      if (context.mounted) {
        context.hideLoader();
      }

      if (context.mounted) {
        context.showSnackSuccess(
          context.translate(JPLocaleKeys.settingsImportAllDataSuccess),
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackError(
          context.translate(JPLocaleKeys.settingsImportAllDataError),
        );
      }
    }
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
      icon: Icons.folder_delete,
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

class _SettingTellMeAJokeContainerWidget extends StatelessWidget {
  const _SettingTellMeAJokeContainerWidget();

  @override
  Widget build(BuildContext context) {
    return _SettingContainerWidget(
      label: context.translate(JPLocaleKeys.settingsJoke),
      icon: Icons.auto_awesome,
      onTap: () async {
        final JokeService jokeService = JokeService(
          languageCode: context.languageCode,
          datasource: context.read<JokeDatasource>(),
        );

        context.showLoader();
        final result = await jokeService.getJoke();
        if (context.mounted) {
          context.hideLoader();
        }

        result.fold(
          ifLeft: (failure) => context.showSnackError(failure.message),
          ifRight: (success) {
            context.showModal(child: _JokeModal(joke: success));
          },
        );
      },
      trailingWidget: Column(
        children: [
          JPSpacingVertical.s,
          const Icon(Icons.chevron_right),
          JPSpacingVertical.s,
        ],
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
                    backgroundColor: context.baseColor,
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

class _JokeModal extends StatefulWidget {
  final JokeModel joke;

  const _JokeModal({required this.joke});

  @override
  State<_JokeModal> createState() => _JokeModalState();
}

class _JokeModalState extends State<_JokeModal> {
  bool showFullJoke = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: JPPadding.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JPSpacingVertical.m,
            JPTitleModal(title: context.translate(JPLocaleKeys.settingsJoke)),
            JPSpacingVertical.m,
            JPText(widget.joke.setupJoke),
            JPSpacingVertical.xl,
            JPActionButtons(
              primaryButtonLabel: showFullJoke
                  ? widget.joke.deliverJoke
                  : context.translate(JPLocaleKeys.settingsJokeReveal),
              onTapPrimaryButton: () {
                showFullJoke = true;
                setState(() {});
              },
              secondaryButtonLabel: context.translate(JPLocaleKeys.close),
              onTapSecondaryButton: context.pop,
              hidePrimaryButton: !(widget.joke.isTwoPart ?? false),
            ),
            JPSpacingVertical.l,
          ],
        ),
      ),
    );
  }
}
