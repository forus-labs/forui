import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class FButtonSpinner extends StatefulWidget {
  const FButtonSpinner({super.key});

  @override
  State<FButtonSpinner> createState() => _ExampleState();
}

class _ExampleState extends State<FButtonSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final FButtonData(:enabled, :style) = FButtonData.of(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.rotate(
        angle: _controller.value * 2 * math.pi,
        child: child,
      ),
      child: FIcon(
        FAssets.icons.loaderCircle,
        color: enabled ? style.contentStyle.enabledIconColor : style.contentStyle.disabledIconColor,
        size: style.contentStyle.iconSize,
        semanticLabel: 'Spinner',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
