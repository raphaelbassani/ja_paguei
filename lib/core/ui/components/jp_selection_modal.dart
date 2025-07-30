import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../ui.dart';

class JPSelectionModal extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? preSelectedValue;
  final String? primaryButtonLabel;
  final Function(String?)? onTapPrimaryButton;
  final String? secondaryButtonLabel;
  final Function()? onTapSecondaryButton;

  const JPSelectionModal({
    required this.title,
    required this.items,
    this.preSelectedValue,
    this.primaryButtonLabel,
    this.onTapPrimaryButton,
    this.secondaryButtonLabel,
    this.onTapSecondaryButton,
    super.key,
  });

  @override
  State<JPSelectionModal> createState() => _JPSelectionModalState();
}

class _JPSelectionModalState extends State<JPSelectionModal> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.preSelectedValue;
  }

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
            JPTitleModal(title: widget.title),
            JPSpacingVertical.m,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return _Item(
                  label: widget.items[index],
                  selectedValue: selectedValue,
                  onTap: (newSelectedValue) {
                    setState(() {
                      if (newSelectedValue == selectedValue) {
                        selectedValue = null;
                      } else {
                        selectedValue = newSelectedValue;
                      }
                    });
                  },
                );
              },
            ),
            JPSpacingVertical.s,
            JPActionButtons(
              primaryButtonLabel: widget.primaryButtonLabel,
              onTapPrimaryButton: () {
                if (widget.onTapPrimaryButton != null) {
                  widget.onTapPrimaryButton!(selectedValue);
                  context.pop();
                  return;
                }
              },
              secondaryButtonLabel: widget.secondaryButtonLabel,
              onTapSecondaryButton: widget.onTapSecondaryButton ?? context.pop,
            ),
            JPSpacingVertical.xl,
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final Function(String) onTap;

  const _Item({
    required this.label,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return JPGestureDetector(
      onTap: () => onTap(label),
      child: Padding(
        padding: JPPadding.bottom,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: JPPadding.horizontal,
            child: Row(
              children: [
                JPText(label),
                const Spacer(),
                Radio<String>(
                  value: label,
                  groupValue: selectedValue,
                  fillColor: WidgetStateProperty<Color>.fromMap(
                    <WidgetStatesConstraint, Color>{
                      WidgetState.focused: Colors.green,
                      WidgetState.pressed |
                              WidgetState.hovered |
                              WidgetState.selected:
                          Colors.green,
                      WidgetState.any: Colors.grey,
                    },
                  ),
                  onChanged: (_) => onTap(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
