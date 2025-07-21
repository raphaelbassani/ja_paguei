import 'package:flutter/material.dart';
import 'package:ja_paguei/ui/spacing.dart';
import 'package:ja_paguei/ui/widgets/jp_text.dart';

enum JPStatusEnum {
  positive(color: Colors.green),
  neutral(color: Colors.grey),
  info(color: Colors.blue),
  warning(color: Colors.orange),
  error(color: Colors.red);

  const JPStatusEnum({required this.color});

  final Color color;
}

class JPStatus extends StatelessWidget {
  final String text;
  final JPStatusEnum status;

  const JPStatus({required this.text, required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [JPSpacingHorizontal.s, JPText(text), JPSpacingHorizontal.s],
      ),
    );
  }
}
