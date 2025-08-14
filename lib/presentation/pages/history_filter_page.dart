import 'package:flutter/material.dart';

import '../../core/ui/components/components.dart';

class HistoryFilterPage extends StatelessWidget {
  const HistoryFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: JPAppBar(title: 'Filtrar'),
      body: CustomScrollView(slivers: []),
    );
  }
}
