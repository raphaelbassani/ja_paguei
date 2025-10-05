import 'package:flutter/material.dart';

import '../../core/extensions.dart';
import '../../core/ui.dart';

class DefaultPaddingWidget extends StatelessWidget {
  const DefaultPaddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isIos) {
      return SliverToBoxAdapter(child: Padding(padding: JPPadding.top * 3));
    }
    return const SliverToBoxAdapter();
  }
}
