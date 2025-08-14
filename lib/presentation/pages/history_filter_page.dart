import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import '../../core/ui/components/components.dart';
import '../../l10n/l10n.dart';

class HistoryFilterPage extends StatelessWidget {
  const HistoryFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(
        title: context.translate(JPLocaleKeys.historyFilterAppBar),
        hasTrailing: true,
      ),
      body: CustomScrollView(slivers: []),
    );
  }
}
