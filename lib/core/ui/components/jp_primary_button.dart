import 'package:flutter/material.dart';

import '../../extensions.dart';
import '../../ui.dart';

class JPPrimaryButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const JPPrimaryButton({required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseButton(label: label, onTap: onTap);
  }
}

class JPPrimaryButtonSmall extends StatelessWidget {
  final String label;
  final Function() onTap;

  const JPPrimaryButtonSmall({
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
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.baseColor,
        minimumSize: isSmall ? const Size(0, 32) : null,
        padding: isSmall ? const EdgeInsets.symmetric(horizontal: 16) : null,
      ),
      child: isSmall
          ? JPText(label, type: JPTextTypeEnum.s, color: Colors.white)
          : Column(
              children: [
                JPSpacingVertical.s,
                JPSpacingVertical.xxs,
                Row(
                  children: [
                    const Spacer(),
                    JPText(label, type: JPTextTypeEnum.m, color: Colors.white),
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
