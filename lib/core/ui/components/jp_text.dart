import 'package:flutter/material.dart';

import '../../extensions.dart';

enum JPTextTypeEnum {
  xxs(fontSize: 8),
  xs(fontSize: 10),
  s(fontSize: 12),
  m(fontSize: 14),
  l(fontSize: 18),
  xl(fontSize: 20),
  xxl(fontSize: 24);

  const JPTextTypeEnum({this.fontSize});

  final double? fontSize;
}

class JPText extends StatelessWidget {
  final String text;
  final JPTextTypeEnum type;
  final bool hasDefaultOpacity;
  final Color? color;

  const JPText(
    this.text, {
    this.type = JPTextTypeEnum.m,
    this.hasDefaultOpacity = false,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textStyle.copyWith(
        fontSize: type.fontSize ?? JPTextTypeEnum.m.fontSize,
        color: (color ?? context.textColor).withAlpha(
          hasDefaultOpacity ? 155 : 255,
        ),
      ),
    );
  }
}
