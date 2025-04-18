import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'progress.style.dart';

/// A progress indicator that shows the completion progress of a task.
///
/// See:
/// * https://forui.dev/docs/feedback/progress for working examples.
/// * [FLinearProgressStyle] for customizing a linear progress indicator's appearance.
abstract class FProgress extends StatefulWidget {
  /// The semantics label.
  final String? semanticsLabel;

  /// The progress value. Defaults to null.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range, `[0.0, 1.0]`.
  ///
  /// A null value indicates an indeterminate progress.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [value] is not null and is less than 0.0 or greater than 1.0.
  final double? value;

  /// Creates a linear [FProgress].
  ///
  /// The [duration] is the duration of the animation. Defaults to 3s if [value] is null and 0.5s otherwise.
  const factory FProgress({
    FLinearProgressStyle? style,
    String? semanticsLabel,
    double? value,
    Duration duration,
    Key? key,
  }) = _Linear;

  /// Creates an indeterminate circular [FProgress].
  const factory FProgress.circularIcon({IconThemeData? style, Duration duration, String? semanticsLabel, Key? key}) =
      _Circular;

  const FProgress._({this.semanticsLabel, this.value, super.key})
    : assert(value == null || value >= 0.0, 'The value must be greater than or equal to 0.0'),
      assert(value == null || value <= 1.0, 'The value must be less than or equal to 1.0');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DoubleProperty('value', value));
  }
}

class _Linear extends FProgress {
  static const _infinite = Duration(milliseconds: 1500);
  static const _finite = Duration(milliseconds: 500);

  final FLinearProgressStyle? style;
  final Duration duration;

  const _Linear({this.style, Duration? duration, super.semanticsLabel, super.value, super.key})
    : duration = duration ?? (value == null ? _infinite : _finite),
      super._();

  @override
  State<_Linear> createState() => _LinearState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('duration', duration));
  }
}

class _LinearState extends State<_Linear> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.duration);
  late CurvedAnimation _curve;
  late Animation<double> _animation;
  double _previous = 0;

  @override
  void initState() {
    super.initState();
    widget.value == null ? _controller.repeat() : _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final style = widget.style ?? context.theme.progressStyles.linearProgressStyle;
    _curve = CurvedAnimation(parent: _controller, curve: style.curve);
    _animation = Tween(begin: _previous, end: widget.value ?? 1).animate(_curve);
  }

  @override
  void didUpdateWidget(covariant _Linear old) {
    super.didUpdateWidget(old);
    var reanimate = false;
    if (widget.duration != old.duration) {
      _controller.duration = widget.duration;
      reanimate = true;
    }

    if (widget.value != old.value) {
      _previous = widget.value == null ? 0 : (old.value ?? 0);
      reanimate = true;
    }

    if (widget.style != old.style) {
      final style = widget.style ?? context.theme.progressStyles.linearProgressStyle;
      _curve = CurvedAnimation(parent: _controller, curve: style.curve);
      reanimate = true;
    }

    if (reanimate) {
      _animation = Tween(begin: _previous, end: widget.value ?? 1).animate(_curve);
      if (widget.value == null) {
        _controller.repeat();
      } else {
        _controller
          ..reset()
          ..forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.progressStyles.linearProgressStyle;
    return ConstrainedBox(
      constraints: style.constraints,
      child: Semantics(
        label: widget.semanticsLabel,
        child: DecoratedBox(
          decoration: style.backgroundDecoration,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (_, child) => FractionallySizedBox(widthFactor: _animation.value, child: child!),
              child: Container(decoration: style.progressDecoration),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }
}

class _Circular extends FProgress {
  final IconThemeData? style;
  final Duration duration;

  const _Circular({this.style, this.duration = const Duration(seconds: 1), super.semanticsLabel, super.key})
    : super._();

  @override
  State<_Circular> createState() => _CircularState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('duration', duration));
  }
}

class _CircularState extends State<_Circular> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant _Circular old) {
    super.didUpdateWidget(old);
    if (widget.duration != old.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style =
        widget.style ??
        context.dependOnInheritedWidgetOfExactType<IconTheme>()?.data ??
        context.theme.progressStyles.circularIconProgressStyle;

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.rotate(angle: _controller.value * 2 * math.pi, child: child),
      child: IconTheme(data: style, child: Icon(FIcons.loaderCircle, semanticLabel: widget.semanticsLabel)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// The progress styles.
class FProgressStyles with Diagnosticable, _$FProgressStylesFunctions {
  /// The linear progress's style.
  @override
  final FLinearProgressStyle linearProgressStyle;

  /// The circular progress's style.
  @override
  final IconThemeData circularIconProgressStyle;

  /// Creates a [FProgressStyles].
  const FProgressStyles({required this.linearProgressStyle, required this.circularIconProgressStyle});

  /// Creates a [FProgressStyles] that inherits its properties.
  FProgressStyles.inherit({required FColors colors, required FStyle style})
    : linearProgressStyle = FLinearProgressStyle.inherit(colors: colors, style: style),
      circularIconProgressStyle = IconThemeData(color: colors.mutedForeground, size: 20);
}

/// A linear [FProgress]'s style.
class FLinearProgressStyle with Diagnosticable, _$FLinearProgressStyleFunctions {
  /// The linear progress's constraints. Defaults to a height of 10.0 and no horizontal constraint.
  @override
  final BoxConstraints constraints;

  /// The progress's background's decoration.
  @override
  final BoxDecoration backgroundDecoration;

  /// The progress's decoration.
  @override
  final BoxDecoration progressDecoration;

  /// The animation curve. Defaults to [Curves.ease].
  @override
  final Curve curve;

  /// Creates a [FLinearProgressStyle].
  const FLinearProgressStyle({
    required this.backgroundDecoration,
    required this.progressDecoration,
    this.constraints = const BoxConstraints.tightFor(height: 10.0),
    this.curve = Curves.ease,
  });

  /// Creates a [FLinearProgressStyle] that inherits its properties.
  FLinearProgressStyle.inherit({required FColors colors, required FStyle style})
    : this(
        backgroundDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
        progressDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.primary),
      );
}
