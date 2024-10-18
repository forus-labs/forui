import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// An animated spinner icon.
///
/// Typically used with an [FButton] as a prefixIcon. The spinner will rotate indefinitely.
/// The spinner's color and size are determined by the parent button's [FButtonCustomStyle].
///
/// See:
/// * https://forui.dev/docs/form/button for working examples.
/// * [FButton] for creating a button.
/// * [FButtonCustomStyle] for customizing a button's appearance.
class FButtonSpinner extends StatefulWidget {
  /// Creates a button spinner.
  const FButtonSpinner({super.key});

  @override
  State<FButtonSpinner> createState() => _FButtonSpinnerState();
}

class _FButtonSpinnerState extends State<FButtonSpinner> with SingleTickerProviderStateMixin {
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
        semanticLabel: 'Button Spinner',
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
