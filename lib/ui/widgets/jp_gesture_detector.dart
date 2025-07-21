import 'package:flutter/material.dart';

class JPGestureDetector extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  const JPGestureDetector({
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(color: Colors.transparent, child: child),
    );
  }
}
