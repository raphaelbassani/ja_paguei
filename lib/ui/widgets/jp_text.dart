import 'package:flutter/material.dart';

import '../../src/helpers/extensions.dart';

enum JPTextTypeEnum {
  xxs(fontSize: 4),
  xs(fontSize: 8),
  s(fontSize: 12),
  m(fontSize: 14),
  l(fontSize: 20),
  xl(fontSize: 24),
  xxl(fontSize: 32);

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
        color: (color ?? context.textStyle.color)!.withAlpha(
          hasDefaultOpacity ? 155 : 255,
        ),
      ),
    );
  }
}
