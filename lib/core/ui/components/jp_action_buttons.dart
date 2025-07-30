import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../extensions/extensions.dart';
import '../ui.dart';

class JPActionButtons extends StatelessWidget {
  final String? primaryButtonLabel;
  final Function()? onTapPrimaryButton;
  final String? secondaryButtonLabel;
  final Function()? onTapSecondaryButton;
  final bool hidePrimaryButton;
  final bool hideSecondaryButton;

  const JPActionButtons({
    this.primaryButtonLabel,
    this.onTapPrimaryButton,
    this.secondaryButtonLabel,
    this.onTapSecondaryButton,
    this.hidePrimaryButton = false,
    this.hideSecondaryButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!hidePrimaryButton)
          JPPrimaryButton(
            onTap: onTapPrimaryButton ?? () {},
            label: primaryButtonLabel ?? context.translate(JPLocaleKeys.save),
          ),
        if (!hideSecondaryButton) ...[
          JPSpacingVertical.s,
          JPSecondaryButton(
            onTap: onTapSecondaryButton ?? () => context.pop(),
            label:
                secondaryButtonLabel ?? context.translate(JPLocaleKeys.cancel),
          ),
        ],
      ],
    );
  }
}
