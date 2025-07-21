import 'package:flutter/material.dart';
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
        '/': (context) => const HomePage(),
        '/new_bill': (context) => const NewBillPage(),
      },
    );
  }
}
