import 'package:flutter/material.dart';

import '../ui.dart';

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
    return _BaseButton(label: label, onTap: onTap);
  }
}

class JPSecondaryButtonSmall extends StatelessWidget {
  final String label;
  final Function() onTap;

  const JPSecondaryButtonSmall({
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseButton(label: label, onTap: onTap, isSmall: true);
  }
}

class _BaseButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool isSmall;

  const _BaseButton({
    required this.label,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.transparent),
      ),
      child: isSmall
          ? JPText(label, type: JPTextTypeEnum.s)
          : Column(
              children: [
                JPSpacingVertical.s,
                JPSpacingVertical.xxs,
                Row(
                  children: [
                    const Spacer(),
                    JPText(label, type: JPTextTypeEnum.m),
                    const Spacer(),
                  ],
                ),
                JPSpacingVertical.s,
                JPSpacingVertical.xxs,
              ],
            ),
    );
  }
}
