import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'progress.design.dart';

/// Am indeterminate linear progress indicator.
///
/// See:
/// * https://forui.dev/docs/feedback/progress for working examples.
/// * [FProgressStyle] for customizing a progress's appearance.
/// * [FDeterminateProgress] for a determinate progress indicator.
/// * [FCircularProgress] for for a circular progress indicator.
class FProgress extends StatefulWidget {
  /// The style.
  final FProgressStyle Function(FProgressStyle style)? style;

  /// The semantics label. Defaults to [FLocalizations.progressSemanticsLabel].
  final String? semanticsLabel;

  /// Creates a determinate [FProgress].
  const FProgress({this.style, this.semanticsLabel, super.key});

  @override
  State<FProgress> createState() => _ProgressState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

class _ProgressState extends State<FProgress> with SingleTickerProviderStateMixin {
  FProgressStyle? _style;
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation _curved = CurvedAnimation(parent: _controller, curve: Curves.linear);
  late Animation<double> _animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setup();
  }

  @override
  void didUpdateWidget(covariant FProgress old) {
    super.didUpdateWidget(old);
    _setup();
  }

  void _setup() {
    final style = widget.style?.call(context.theme.progressStyle) ?? context.theme.progressStyle;
    if (_style != style) {
      _style = style;

      final total = style.motion.period + style.motion.interval;
      final curve = Interval(0, style.motion.period.inMilliseconds / total.inMilliseconds, curve: style.motion.curve);

      _controller
        ..duration = total
        ..repeat();
      _curved.curve = curve;
      _animation = Tween<double>(begin: -style.motion.value, end: 1).animate(_curved);
    }
  }

  @override
  void dispose() {
    _curved.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: _style!.constraints,
    child: Semantics(
      label: widget.semanticsLabel ?? (FLocalizations.of(context) ?? FDefaultLocalizations()).progressSemanticsLabel,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: _style!.trackDecoration,
        child: LayoutBuilder(
          builder: (context, constraints) => AnimatedBuilder(
            animation: _animation,
            builder: (_, child) => Stack(
              children: [
                PositionedDirectional(
                  start: constraints.maxWidth * (_animation.value),
                  width: constraints.maxWidth * _style!.motion.value,
                  top: 0,
                  bottom: 0,
                  child: child!,
                ),
              ],
            ),
            child: DecoratedBox(decoration: _style!.fillDecoration),
          ),
        ),
      ),
    ),
  );
}

/// A [FProgress]'s style.
class FProgressStyle with Diagnosticable, _$FProgressStyleFunctions {
  /// The linear progress's constraints. Defaults to a height of 10.0 and no horizontal constraint.
  @override
  final BoxConstraints constraints;

  /// The track's decoration.
  @override
  final BoxDecoration trackDecoration;

  /// The fill's decoration.
  @override
  final BoxDecoration fillDecoration;

  /// The motion-related properties for an indeterminate [FProgress].
  @override
  final FProgressMotion motion;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.trackDecoration,
    required this.fillDecoration,
    this.constraints = const BoxConstraints.tightFor(height: 10.0),
    this.motion = const FProgressMotion(),
  });

  /// Creates a [FProgressStyle] that inherits its properties.
  FProgressStyle.inherit({required FColors colors, required FStyle style})
    : this(
        trackDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
        fillDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.primary),
      );
}

/// Motion-related properties for an indeterminate [FProgress].
class FProgressMotion with Diagnosticable, _$FProgressMotionFunctions {
  /// The animation's period. Defaults to 1s.
  @override
  final Duration period;

  /// The interval between animations. Defaults to 500ms.
  @override
  final Duration interval;

  /// The animation curve. Defaults to [Curves.ease].
  @override
  final Curve curve;

  /// The percentage of the filled progress. Defaults to 0.4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if outside the range of 0.0 to 1.0.
  @override
  final double value;

  /// Creates a [FProgressMotion].
  const FProgressMotion({
    this.period = const Duration(milliseconds: 1000),
    this.interval = const Duration(milliseconds: 500),
    this.curve = Curves.ease,
    this.value = 0.4,
  }) : assert(value >= 0.0 && value <= 1.0, 'value ($value) must be between 0.0 and 1.0');
}
