import 'package:flutter/material.dart';

import '../../ui.dart';
import '../helpers/extensions.dart';
import '../helpers/format.dart';
import '../models/bill_model.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController valueController = TextEditingController();
  late final TextEditingController dataController = TextEditingController();
  late BillModel? editBill;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editBill = context.arguments as BillModel?;
      if (editBill != null) {
        nameController.text = editBill!.name;
        valueController.text = Format.currencyIntoString(editBill!.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JPAppBar(title: 'Criar conta', hasTrailing: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome da conta',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
