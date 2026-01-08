import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'theme.design.dart';

/// Applies a theme to descendant widgets with animated transitions over a given duration whenever the provided
/// [FThemeData] changes.
///
/// A theme configures the colors and typographic choices of Forui widgets. The actual configuration is stored in
/// a [FThemeData]. Descendant widgets obtain the current theme's [FThemeData] via either [FThemeBuildContext.theme],
/// or [FTheme.of]. When a widget uses either, it is automatically rebuilt if the theme later changes.
///
/// ```dart
/// class Parent extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) => FTheme(
///      data: FThemes.zinc.light,
///      child: Child(),
///    );
///  }
///
///  class Child extends StatelessWidget {
///    @override
///    Widget build(BuildContext context) {
///      final FThemeData theme = context.theme;
///      final FThemeData sameTheme = FTheme.of(context);
///
///      return const Placeholder();
///    }
///  }
/// ```
///
/// See:
/// * [FBasicTheme], the non-animated theme widget wrapped by this widget.
/// * [FThemeData] which describes the actual configuration of a theme.
class FTheme extends ImplicitlyAnimatedWidget {
  /// Returns the current [FThemeData], or `FThemes.zinc.light` if there is no ancestor [FTheme].
  ///
  /// It is recommended to use the terser [FThemeBuildContext.theme] getter instead.
  ///
  /// ## Troubleshooting:
  ///
  /// ### [FTheme.of] always returns `FThemes.zinc.light`
  ///
  /// One of the most common causes is calling [FTheme.of] in the same context which [FTheme] was declared. To fix this,
  /// move the call to [FTheme.of] to a descendant widget.
  ///
  /// ✅ Do:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.zinc.light,
  ///      child: Child(),
  ///    );
  ///  }
  ///
  ///  class Child extends StatelessWidget {
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      final FThemeData theme = FTheme.of(context);
  ///      return const SomeWidget(theme: theme);
  ///    }
  ///  }
  /// ```
  ///
  /// ❌ Do not:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.zinc.light,
  ///      child: SomeWidget(
  ///        theme: FTheme.of(context), // Whoops!
  ///      ),
  ///    );
  ///  }
  /// ```
  @useResult
  static FThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return theme?.data ?? FThemes.zinc.light;
  }

  /// Motion-related properties for the animation.
  final FThemeMotion motion;

  /// The theme.
  final FThemeData data;

  /// The text direction. Defaults to the text direction inherited from its nearest ancestor.
  final TextDirection? textDirection;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an animated theme.
  FTheme({
    required this.data,
    required this.child,
    this.textDirection,
    this.motion = const FThemeMotion(),
    super.onEnd,
    super.key,
  }) : super(duration: motion.duration, curve: motion.curve);

  @override
  AnimatedWidgetBaseState<FTheme> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('motion', motion))
      ..add(DiagnosticsProperty('data', data))
      ..add(EnumProperty('textDirection', textDirection));
  }
}

class _State extends AnimatedWidgetBaseState<FTheme> {
  _Tween? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(_tween, widget.data, (value) => _Tween(begin: value as FThemeData))! as _Tween;
  }

  @override
  Widget build(BuildContext context) => FBasicTheme(
    data: _tween!.evaluate(animation),
    textDirection: widget.textDirection ?? Directionality.maybeOf(context) ?? .ltr,
    child: widget.child,
  );
}

class _Tween extends Tween<FThemeData> {
  _Tween({super.begin});

  @override
  FThemeData lerp(double t) => FThemeData.lerp(begin!, end!, t);
}

/// The motion-related properties for [FTheme].
class FThemeMotion with Diagnosticable, _$FThemeMotionFunctions {
  /// The animation's duration. Defaults to 200 milliseconds.
  @override
  final Duration duration;

  /// The animation's curve. Defaults to [Curves.linear].
  ///
  /// We recommend [Curves.linear], especially if only the theme's colors are changing.
  /// See https://pow.rs/blog/animation-easings/ for more information.
  @override
  final Curve curve;

  /// Creates a [FThemeMotion].
  const FThemeMotion({this.duration = const Duration(milliseconds: 200), this.curve = Curves.linear});
}

/// Provides functions for accessing the current [FThemeData].
extension FThemeBuildContext on BuildContext {
  /// Returns the current [FThemeData], or `FThemes.zinc.light` if there is no ancestor [FTheme].
  ///
  /// ## Troubleshooting:
  ///
  /// ### [theme] always returns `FThemes.zinc.light`
  ///
  /// One of the most common causes is calling [theme] in the same context which [FTheme] was declared. To fix this,
  /// move the call to [theme] to a descendant widget.
  ///
  /// ✅ Do:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.zinc.light,
  ///      child: Child(),
  ///    );
  ///  }
  ///
  ///  class Child extends StatelessWidget {
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      final FThemeData theme = context.theme;
  ///      return const SomeWidget(theme: theme);
  ///    }
  ///  }
  /// ```
  ///
  /// ❌ Do not:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.zinc.light,
  ///      child: SomeWidget(
  ///        theme: context.theme, // Whoops!
  ///      ),
  ///    );
  ///  }
  /// ```
  FThemeData get theme => FTheme.of(this);
}

/// Applies a theme to descendant widgets.
///
/// See:
/// * [FTheme] which is an animated version of this widget.
/// * [FThemeData] which describes the actual configuration of a theme.
class FBasicTheme extends StatelessWidget {
  /// The color and typography values for descendant Forui widgets.
  final FThemeData data;

  /// The text direction. Defaults to the text direction inherited from its nearest ancestor.
  final TextDirection? textDirection;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a [FTheme] that applies [data] to all descendant widgets in [child].
  const FBasicTheme({required this.data, required this.child, this.textDirection, super.key});

  @override
  Widget build(BuildContext context) => _InheritedTheme(
    data: data,
    child: Directionality(
      textDirection: textDirection ?? Directionality.maybeOf(context) ?? .ltr,
      child: DefaultTextStyle(
        style: data.typography.base.copyWith(
          fontFamily: data.typography.defaultFontFamily,
          color: data.colors.foreground,
        ),
        child: child,
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('data', data, showName: false))
      ..add(EnumProperty('textDirection', textDirection));
  }
}

class _InheritedTheme extends InheritedTheme {
  final FThemeData data;

  const _InheritedTheme({required this.data, required super.child});

  @override
  Widget wrap(BuildContext context, Widget child) => _InheritedTheme(data: data, child: child);

  @override
  bool updateShouldNotify(covariant _InheritedTheme old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}
