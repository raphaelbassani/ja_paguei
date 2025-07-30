import 'package:flutter/material.dart';

import '../ui.dart';

class JPFab extends StatelessWidget {
  final String label;
  final Function() onTap;

  const JPFab({required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: JPText(label, color: Colors.white),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.add, color: Colors.white),
      onPressed: onTap,
    );
  }
}
