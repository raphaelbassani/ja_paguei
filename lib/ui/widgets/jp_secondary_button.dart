import 'package:flutter/material.dart';

import '../../ui.dart';

class JPSecondaryButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const JPSecondaryButton({
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.transparent),
      ),
      child: Column(
        children: [
          JPSpacingVertical.s,
          JPSpacingVertical.xxs,
          Row(
            children: [
              Spacer(),
              JPText(label, type: JPTextTypeEnum.m),
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
