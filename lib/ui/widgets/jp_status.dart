import 'package:flutter/material.dart';

import '../spacing.dart';
import 'jp_text.dart';

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
    return Row(
      children: [
        Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: status.color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JPSpacingVertical.xxs,
              Row(
                children: [
                  JPSpacingHorizontal.s,
                  JPText(text, color: Colors.white, type: JPTextTypeEnum.s),
                  JPSpacingHorizontal.s,
                ],
              ),
              JPSpacingVertical.xxs,
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
