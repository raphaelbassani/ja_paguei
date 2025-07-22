import 'package:flutter/material.dart';

import '../../ui.dart';

class JPSelectionSwitch extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onTap;

  const JPSelectionSwitch({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        JPText(label),
        Spacer(),
        Switch(value: isSelected, onChanged: onTap),
      ],
    );
  }
}
