import 'package:flutter/material.dart';

class JPGestureDetector extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;

  const JPGestureDetector({
    required this.child,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(color: Colors.transparent, child: child),
    );
  }
}
