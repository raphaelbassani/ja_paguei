import 'package:flutter/material.dart';

import '../../src/helpers/extensions.dart';
import '../../ui.dart';

class JPAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  final bool hasTrailing;

  JPAppBar({
    required this.title,
    this.hasLeading = false,
    this.hasTrailing = false,
    super.key,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  State<JPAppBar> createState() => _JPAppBarState();

  @override
  final Size preferredSize;
}

class _JPAppBarState extends State<JPAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: JPText(widget.title, type: JPTextTypeEnum.l),
      actions: widget.hasTrailing
          ? [
              Padding(
                padding: JPPadding.right,
                child: JPGestureDetector(
                  child: Icon(Icons.close),
                  onTap: () => context.popUntilIsRoot(),
                ),
              ),
            ]
          : null,
      leading: widget.hasLeading
          ? Padding(
              padding: JPPadding.left - EdgeInsets.only(left: 9),
              child: JPGestureDetector(
                child: Icon(Icons.arrow_back_rounded),
                onTap: () => context.pop(),
              ),
            )
          : null,
    );
  }
}
