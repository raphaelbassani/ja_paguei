import 'package:flutter/material.dart';

import '../../core/ui.dart';

class DefaultPaddingWidget extends StatelessWidget {
  const DefaultPaddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Padding(padding: JPPadding.top * 3));
  }
}
