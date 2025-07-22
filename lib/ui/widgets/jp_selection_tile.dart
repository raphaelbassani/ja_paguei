import 'package:flutter/material.dart';

import '../../ui.dart';

class JPSelectionTile extends StatelessWidget {
  final String title;
  final String info;
  final Function() onTap;

  const JPSelectionTile({
    required this.title,
    required this.info,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JPText(title, hasDefaultOpacity: true),
                JPSpacingVertical.xs,
                JPText(info),
              ],
            ),
            Spacer(),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
