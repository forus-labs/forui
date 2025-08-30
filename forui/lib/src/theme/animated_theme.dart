import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'animated_theme.design.dart';

/// An animated version of [FTheme] which automatically transitions the colors, typography, and other properties over a
/// given duration whenever the provided [FThemeData] changes.
///
/// See:
/// * [FTheme] which is a non-animated version of this widget.
/// * [FThemeData] which describes the actual configuration of a theme.
class FAnimatedTheme extends ImplicitlyAnimatedWidget {
  /// Motion-related properties for the animation.
  final FAnimatedThemeMotion motion;

  /// The theme.
  final FThemeData data;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an animated theme.
  FAnimatedTheme({
    required this.data,
    required this.child,
    this.motion = const FAnimatedThemeMotion(),
    super.onEnd,
    super.key,
  }) : super(duration: motion.duration, curve: motion.curve);

  @override
  AnimatedWidgetBaseState<FAnimatedTheme> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('motion', motion))
      ..add(DiagnosticsProperty('data', data));
  }
}

class _State extends AnimatedWidgetBaseState<FAnimatedTheme> {
  _Tween? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(_tween, widget.data, (value) => _Tween(begin: value as FThemeData))! as _Tween;
  }

  @override
  Widget build(BuildContext context) => FTheme(data: _tween!.evaluate(animation), child: widget.child);
}

class _Tween extends Tween<FThemeData> {
  _Tween({super.begin});

  @override
  FThemeData lerp(double t) => FThemeData.lerp(begin!, end!, t);
}

/// The motion-related properties for [FAnimatedTheme].
class FAnimatedThemeMotion with Diagnosticable, _$FAnimatedThemeMotionFunctions {
  /// The animation's duration. Defaults to 200 milliseconds.
  @override
  final Duration duration;

  /// The animation's curve. Defaults to [Curves.linear].
  ///
  /// We recommend [Curves.linear], especially if only the theme's colors are changing.
  /// See https://pow.rs/blog/animation-easings/ for more information.
  @override
  final Curve curve;

  /// Creates a [FAnimatedThemeMotion].
  const FAnimatedThemeMotion({this.duration = const Duration(milliseconds: 200), this.curve = Curves.linear});
}
