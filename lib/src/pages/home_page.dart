import 'package:flutter/material.dart';
import 'package:ja_paguei/src/helpers/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    _BaseScreenWidget(title: 'Minha conta'),
    _BaseScreenWidget(title: 'Meus pedidos'),
    _BaseScreenWidget(title: 'Balanço'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Já Paguei'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(Routes.newBill),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Contas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Balanço',
          ),
        ],
      ),
      body: _telas[_indiceAtual],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}

class _BaseScreenWidget extends StatelessWidget {
  final String title;

  const _BaseScreenWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(slivers: []);
  }
}
