import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_spinner.style.dart';

/// An animated spinner icon.
///
/// Should only be used with an [FButton] as a prefixIcon. The spinner will rotate indefinitely.
/// The spinner's color and size defaults to the parent button's [FBaseButtonStyle].
///
/// See:
/// * https://forui.dev/docs/form/button for working examples.
/// * [FButton] for creating a button.
/// * [FButtonStyle] for customizing a button's appearance.
class FButtonSpinner extends StatefulWidget {
  /// The style. Defaults to the parent button's [FButtonSpinnerStyle].
  ///
  /// Typically used to change the size and animation duration of the spinner.
  final FButtonSpinnerStyle? style;

  /// Creates a button spinner.
  const FButtonSpinner({this.style, super.key});

  @override
  State<FButtonSpinner> createState() => _FButtonSpinnerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

class _FButtonSpinnerState extends State<FButtonSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late FButtonSpinnerStyle _style;
  late FButtonData _data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _data = FButtonData.of(context);
    _style = widget.style ?? _data.style.spinnerStyle;

    _controller =
        AnimationController(vsync: this, duration: _style.animationDuration)
          ..forward()
          ..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (_, child) => Transform.rotate(angle: _controller.value * 2 * math.pi, child: child),
    child: FIcon(
      FAssets.icons.loaderCircle,
      color: _style.color.resolve(_data.states),
      size: _style.size,
      semanticLabel: 'Button Spinner',
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// [FButton] spinner's style.
final class FButtonSpinnerStyle with Diagnosticable, _$FButtonSpinnerStyleFunctions {
  /// The animation duration. Defaults to 1 second`.
  @override
  final Duration animationDuration;

  /// The spinner's color.
  @override
  final FWidgetStateMap<Color> color;

  /// The spinner's size. Defaults to 20.
  @override
  final double size;

  /// Creates a [FButtonSpinnerStyle].
  FButtonSpinnerStyle({
    required this.color,
    this.animationDuration = const Duration(seconds: 1),
    this.size = 20,
  });
}
