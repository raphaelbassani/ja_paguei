import 'package:flutter/material.dart';

import '../../ui.dart';

class JPPrimaryButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const JPPrimaryButton({required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: Column(
        children: [
          JPSpacingVertical.s,
          JPSpacingVertical.xxs,
          Row(
            children: [
              Spacer(),
              JPText(label, type: JPTextTypeEnum.m, color: Colors.white),
              Spacer(),
            ],
          ),
          JPSpacingVertical.s,
          JPSpacingVertical.xxs,
        ],
      ),
    );
  }
}
