import 'package:flutter/material.dart';

import '../../ui.dart';

class JPSelectionSwitch extends StatefulWidget {
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
  State<JPSelectionSwitch> createState() => _JPSelectionSwitchState();
}

class _JPSelectionSwitchState extends State<JPSelectionSwitch> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return JPGestureDetector(
      onTap: selection,
      child: Row(
        children: [
          JPText(widget.label),
          Spacer(),
          Switch(
            value: widget.isSelected,
            onChanged: (_) => selection(),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  void selection() {
    setState(() {
      isSelected = isSelected ? false : true;
    });
    widget.onTap(isSelected);
  }
}
