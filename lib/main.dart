import 'package:flutter/material.dart';
import 'package:ja_paguei/src/helpers/routes.dart';
import 'package:ja_paguei/src/pages/home_page.dart';
import 'package:ja_paguei/src/pages/new_bill_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Já Paguei',
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.newBill: (context) => const NewBillPage(),
      },
    );
  }
}
