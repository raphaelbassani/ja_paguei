import 'package:flutter/material.dart';
import 'package:ja_paguei/ui.dart';

class NewBillPage extends StatelessWidget {
  const NewBillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(
        title: 'Criar conta',
        hasLeading: true,
        hasTrailing: true,
      ),
      body: CustomScrollView(slivers: []),
    );
  }
}
