import 'package:flutter/material.dart';

/// Uses [ValueNotifier] and [ValueListenableBuilder] to listen for hover
class HoverBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;
  final HitTestBehavior? hitTestBehavior;
  final MouseCursor cursor;
  final bool opaque;

  const HoverBuilder({
    super.key,
    required this.builder,
    this.hitTestBehavior,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
  });

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: widget.hitTestBehavior,
      cursor: widget.cursor,
      opaque: widget.opaque,
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (context, hovered, _) => widget.builder(context, hovered),
      ),
    );
  }
}
