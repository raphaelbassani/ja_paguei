import 'package:flutter/material.dart';
import 'package:ja_paguei/src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Já Paguei',
      home: const HomePage(),
    );
  }
}
