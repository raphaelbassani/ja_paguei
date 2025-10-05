import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/material.dart';

import '../../extensions.dart';
import '../../ui.dart';

class JPSelectionSwitch extends StatefulWidget {
  final String? label;
  final bool isSelected;
  final Function(bool) onTap;

  const JPSelectionSwitch({
    required this.isSelected,
    required this.onTap,
    this.label,
    super.key,
  });

  @override
  State<JPSelectionSwitch> createState() => _JPSelectionSwitchState();
}

class _JPSelectionSwitchState extends State<JPSelectionSwitch> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.label != null) {
      return JPGestureDetector(
        onTap: selection,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: JPText(widget.label!)),
            _SwitchWidget(isSelected: widget.isSelected, onTap: widget.onTap),
          ],
        ),
      );
    }

    return _SwitchWidget(isSelected: widget.isSelected, onTap: widget.onTap);
  }

  void selection() {
    setState(() {
      isSelected = isSelected ? false : true;
    });
    widget.onTap(isSelected);
  }
}

class _SwitchWidget extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onTap;

  const _SwitchWidget({required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return context.isIos
        ? CNSwitch(value: isSelected, onChanged: onTap, color: Colors.green)
        : Switch(
            value: isSelected,
            onChanged: onTap,
            activeThumbColor: Colors.green,
          );
  }
}
