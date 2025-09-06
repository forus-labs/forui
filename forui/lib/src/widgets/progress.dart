import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'progress.design.dart';

/// A linear progress indicator.
///
/// See:
/// * https://forui.dev/docs/feedback/progress for working examples.
/// * [FProgressStyle] for customizing a circular progress's appearance.
/// * [FCircularProgress] for for a circular progress indicator.
class FProgress extends StatefulWidget {
  static const _infinite = Duration(milliseconds: 1500);
  static const _finite = Duration(milliseconds: 500);

  /// The style.
  final FProgressStyle Function(FProgressStyle style)? style;

  /// The semantics label.
  final String? semanticsLabel;

  /// Creates a [FProgress].
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
    final style =
        widget.style?.call(context.theme.progressStyles.linearProgressStyle) ??
        context.theme.progressStyles.linearProgressStyle;

    _curve = CurvedAnimation(parent: _controller, curve: style.curve);
    _animation = Tween(begin: _previous, end: widget.value ?? 1).animate(_curve);
  }

  @override
  void didUpdateWidget(covariant FProgress old) {
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
      final style =
          widget.style?.call(context.theme.progressStyles.linearProgressStyle) ??
          context.theme.progressStyles.linearProgressStyle;

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
    final style = widget.style?.call(context.theme.progressStyle) ?? context.theme.progressStyle;
    return ConstrainedBox(
      constraints: style.constraints,
      child: Semantics(
        label: widget.semanticsLabel ?? (FLocalizations.of(context) ?? FDefaultLocalizations()).progressSemanticsLabel,
        child: DecoratedBox(
          decoration: style.trackDecoration,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (_, child) => FractionallySizedBox(widthFactor: _animation.value, child: child!),
              child: Container(decoration: style.fillDecoration),
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

  /// The animation curve. Defaults to [Curves.ease].
  @override
  final Curve curve;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.trackDecoration,
    required this.fillDecoration,
    this.constraints = const BoxConstraints.tightFor(height: 10.0),
    this.curve = Curves.ease,
  });

  /// Creates a [FProgressStyle] that inherits its properties.
  FProgressStyle.inherit({required FColors colors, required FStyle style})
    : this(
        trackDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
        fillDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.primary),
      );
}

/// An indeterminate circular progress indicator.
///
/// See:
/// * https://forui.dev/docs/feedback/circular-progress for working examples.
/// * [FCircularProgressStyle] for customizing a circular progress's appearance.
/// * [FProgress] for for a linear progress indicator.
class FCircularProgress extends StatefulWidget {
  /// The style.
  final FCircularProgressStyle Function(FCircularProgressStyle style)? style;

  /// The semantics label.
  final String? semanticsLabel;

  /// The icon.
  final IconData icon;

  /// Creates a [FCircularProgress] that uses [FIcons.loaderCircle].
  const FCircularProgress({this.style, this.semanticsLabel, this.icon = FIcons.loaderCircle, super.key});

  /// Creates a [FCircularProgress] that uses [FIcons.loader].
  const FCircularProgress.loader({this.style, this.semanticsLabel, this.icon = FIcons.loader, super.key});

  /// Creates a [FCircularProgress] that uses [FIcons.loaderPinwheel].
  const FCircularProgress.pinwheel({this.style, this.semanticsLabel, this.icon = FIcons.loaderPinwheel, super.key});

  @override
  State<FCircularProgress> createState() => _CircularState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(IconDataProperty('icon', icon));
  }
}

class _CircularState extends State<FCircularProgress> with SingleTickerProviderStateMixin {
  FCircularProgressStyle? _style;
  AnimationController? _controller;
  CurvedAnimation? _curveRotation;
  Animation<double>? _rotation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupRotationAnimation();
  }

  @override
  void didUpdateWidget(covariant FCircularProgress old) {
    super.didUpdateWidget(old);
    _setupRotationAnimation();
  }

  void _setupRotationAnimation() {
    final style = widget.style?.call(context.theme.circularProgressStyle) ?? context.theme.circularProgressStyle;
    if (_style != style) {
      _style = style;
      _curveRotation?.dispose();
      _controller?.dispose();

      _controller = AnimationController(vsync: this, duration: style.motion.duration)..repeat();
      _curveRotation = CurvedAnimation(parent: _controller!, curve: style.motion.curve);
      _rotation = style.motion.tween.animate(_curveRotation!);
    }
  }

  @override
  void dispose() {
    _curveRotation?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semanticsLabel =
        widget.semanticsLabel ?? (FLocalizations.of(context) ?? FDefaultLocalizations()).progressSemanticsLabel;
    return AnimatedBuilder(
      animation: _rotation!,
      builder: (_, child) => Transform.rotate(angle: _rotation!.value * 2 * math.pi, child: child),
      child: IconTheme(
        data: _style!.iconStyle,
        child: Icon(widget.icon, semanticLabel: semanticsLabel),
      ),
    );
  }
}

/// The style for [FCircularProgress].
class FCircularProgressStyle with Diagnosticable, _$FCircularProgressStyleFunctions {
  /// The circular progress's style.
  @override
  final IconThemeData iconStyle;

  /// The motion-related properties.
  @override
  final FCircularProgressMotion motion;

  /// Creates a [FCircularProgressStyle].
  FCircularProgressStyle({required this.iconStyle, this.motion = const FCircularProgressMotion()});

  /// Creates a [FCircularProgressStyle].
  FCircularProgressStyle.inherit({required FColors colors})
    : this(iconStyle: IconThemeData(color: colors.mutedForeground, size: 20));
}

/// Motion-related properties for [FCircularProgress].
class FCircularProgressMotion with Diagnosticable, _$FCircularProgressMotionFunctions {
  /// The duration of one full rotation. Defaults to 1s.
  @override
  final Duration duration;

  /// The animation curve. Defaults to [Curves.linear].
  @override
  final Curve curve;

  /// The rotation's tween. Defaults to `FImmutableTween(begin: 0.0, end: 1.0)`. Reverse to rotate counter-clockwise.
  @override
  final Animatable<double> tween;

  /// Creates a [FCircularProgressMotion].
  const FCircularProgressMotion({
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.linear,
    this.tween = const FImmutableTween(begin: 0.0, end: 1.0),
  });
}
