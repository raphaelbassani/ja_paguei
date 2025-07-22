import 'package:flutter/material.dart';

import '../../src/helpers/extensions.dart';
import '../../ui.dart';

class JPActionButtons extends StatelessWidget {
  final String? primaryButtonLabel;
  final Function()? onTapPrimaryButton;
  final String? secondaryButtonLabel;
  final Function()? onTapSecondaryButton;

  const JPActionButtons({
    this.primaryButtonLabel,
    this.onTapPrimaryButton,
    this.secondaryButtonLabel,
    this.onTapSecondaryButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        JPPrimaryButton(
          onTap: onTapPrimaryButton ?? () {},
          label: primaryButtonLabel ?? 'Salvar',
        ),
        JPSpacingVertical.s,
        JPSecondaryButton(
          onTap: onTapSecondaryButton ?? () => context.pop(),
          label: secondaryButtonLabel ?? 'Cancelar',
        ),
      ],
    );
  }
}
