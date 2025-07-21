import 'package:flutter/material.dart';
import 'package:ja_paguei/ui.dart';

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
      centerTitle: !widget.hasLeading && !widget.hasTrailing,
      title: Padding(
        padding: widget.hasLeading ? JPPadding.left : EdgeInsets.zero,
        child: JPText('Já Paguei', type: JPTextTypeEnum.l),
      ),
      actions: [if (widget.hasTrailing) Icon(Icons.close)],
      leading: widget.hasLeading ? Icon(Icons.arrow_back_rounded) : null,
    );
  }
}
