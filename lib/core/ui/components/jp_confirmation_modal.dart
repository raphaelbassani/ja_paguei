import 'package:flutter/material.dart';

import '../ui.dart';

class JPConfirmationModal extends StatelessWidget {
  final String title;
  final String? info;
  final String? primaryButtonLabel;
  final Function()? onTapPrimaryButton;
  final String? secondaryButtonLabel;
  final Function()? onTapSecondaryButton;
  final Widget? customWidgetBody;
  final bool hidePrimaryButton;
  final bool hideSecondaryButton;

  const JPConfirmationModal({
    required this.title,
    this.info,
    this.primaryButtonLabel,
    this.onTapPrimaryButton,
    this.secondaryButtonLabel,
    this.onTapSecondaryButton,
    this.customWidgetBody,
    this.hidePrimaryButton = false,
    this.hideSecondaryButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: JPPadding.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JPSpacingVertical.m,
            JPTitleModal(title: title),
            if (info != null) ...[JPSpacingVertical.m, JPText(info!)],
            if (customWidgetBody != null) customWidgetBody!,
            JPSpacingVertical.xl,
            JPActionButtons(
              primaryButtonLabel: primaryButtonLabel,
              onTapPrimaryButton: onTapPrimaryButton,
              secondaryButtonLabel: secondaryButtonLabel,
              onTapSecondaryButton: onTapSecondaryButton,
              hidePrimaryButton: hidePrimaryButton,
              hideSecondaryButton: hideSecondaryButton,
            ),
            JPSpacingVertical.l,
          ],
        ),
      ),
    );
  }
}
