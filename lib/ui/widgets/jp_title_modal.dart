import 'package:flutter/material.dart';

import '../../src/helpers/extensions.dart';
import '../../ui.dart';

class JPTitleModal extends StatelessWidget {
  final String title;

  const JPTitleModal({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        JPText(title, type: JPTextTypeEnum.xl),
        Spacer(),
        JPGestureDetector(onTap: context.pop, child: Icon(Icons.close)),
      ],
    );
  }
}
