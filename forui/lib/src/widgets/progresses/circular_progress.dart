import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'circular_progress.design.dart';

/// An indeterminate circular progress indicator.
///
/// See:
/// * https://forui.dev/docs/feedback/circular-progress for working examples.
/// * [FCircularProgressStyle] for customizing a circular progress's appearance.
/// * [FProgress] for for an indeterminate linear progress indicator.
class FCircularProgress extends StatefulWidget {
  /// The style.
  final FCircularProgressStyle Function(FCircularProgressStyle style)? style;

  /// The semantics label. Defaults to [FLocalizations.progressSemanticsLabel].
  final String? semanticsLabel;

  /// The icon.
  final IconData icon;

  /// Creates a [FCircularProgress] that uses [FIcons.loaderCircle].
  const FCircularProgress({this.style, this.semanticsLabel, this.icon = FIcons.loaderCircle, super.key});

  /// Creates a [FCircularProgress] that uses [FIcons.loader].
  const FCircularProgress.loader({this.style, this.semanticsLabel, super.key}) : icon = FIcons.loader;

  /// Creates a [FCircularProgress] that uses [FIcons.loaderPinwheel].
  const FCircularProgress.pinwheel({this.style, this.semanticsLabel, super.key}) : icon = FIcons.loaderPinwheel;

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
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation _curveRotation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  late Animation<double> _rotation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setup();
  }

  @override
  void didUpdateWidget(covariant FCircularProgress old) {
    super.didUpdateWidget(old);
    _setup();
  }

  void _setup() {
    final inherited = FInheritedCircularProgressStyle.of(context);
    final style = widget.style?.call(inherited) ?? inherited;
    if (_style != style) {
      _style = style;
      _controller
        ..duration = style.motion.duration
        ..repeat();
      _curveRotation.curve = style.motion.curve;
      _rotation = style.motion.tween.animate(_curveRotation);
    }
  }

  @override
  void dispose() {
    _curveRotation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semanticsLabel =
        widget.semanticsLabel ?? (FLocalizations.of(context) ?? FDefaultLocalizations()).progressSemanticsLabel;
    return AnimatedBuilder(
      animation: _rotation,
      builder: (_, child) => Transform.rotate(angle: _rotation.value * 2 * math.pi, child: child),
      child: IconTheme(
        data: _style!.iconStyle,
        child: Icon(widget.icon, semanticLabel: semanticsLabel),
      ),
    );
  }
}

/// An inherited widget that provides [FCircularProgressStyle] to its descendants.
class FInheritedCircularProgressStyle extends InheritedWidget {
  /// The circular progress's style.
  final FCircularProgressStyle style;

  /// Returns the current [FCircularProgressStyle].
  static FCircularProgressStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FInheritedCircularProgressStyle>()?.style ??
      context.theme.circularProgressStyle;

  /// Creates a [FInheritedCircularProgressStyle].
  const FInheritedCircularProgressStyle({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FInheritedCircularProgressStyle old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
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
