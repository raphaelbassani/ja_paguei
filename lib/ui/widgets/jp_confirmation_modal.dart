import 'package:flutter/material.dart';

import '../../ui.dart';
import 'jp_title_modal.dart';

class JPConfirmationModal extends StatelessWidget {
  final String title;
  final String info;
  final String? primaryButtonLabel;
  final Function()? onTapPrimaryButton;
  final String? secondaryButtonLabel;
  final Function()? onTapSecondaryButton;

  const JPConfirmationModal({
    required this.title,
    required this.info,
    this.primaryButtonLabel,
    this.onTapPrimaryButton,
    this.secondaryButtonLabel,
    this.onTapSecondaryButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
        padding: JPPadding.horizontal,
        child: Column(
          children: [
            JPSpacingVertical.m,
            JPTitleModal(title: title),
            JPSpacingVertical.m,
            JPText(info),
            JPSpacingVertical.xl,
            JPActionButtons(
              primaryButtonLabel: primaryButtonLabel,
              onTapPrimaryButton: onTapPrimaryButton,
              secondaryButtonLabel: secondaryButtonLabel,
              onTapSecondaryButton: onTapSecondaryButton,
            ),
            JPSpacingVertical.l,
          ],
        ),
      ),
    );
  }
}
