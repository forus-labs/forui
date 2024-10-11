import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// Applies a theme to descendant widgets.
///
/// A theme configures the colors and typographic choices of Forui widgets. The actual configuration is stored in
/// a [FThemeData]. Descendant widgets obtain the current theme's [FThemeData] via either [ThemeBuildContext.theme],
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
/// See [FThemeData] which describes of the actual configuration of a theme.
class FTheme extends StatelessWidget {
  /// Returns the current [FThemeData], or `FThemes.zinc.light` if there is no ancestor [FTheme].
  ///
  /// It is recommended to use the terser [ThemeBuildContext.theme] getter instead.
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

  /// The color and typography values for descendant Forui widgets.
  final FThemeData data;

  /// The text direction. Defaults to the text direction inherited from its nearest ancestor.
  final TextDirection? textDirection;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a [FTheme] that applies [data] to all descendant widgets in [child].
  const FTheme({
    required this.data,
    required this.child,
    this.textDirection,
    super.key,
  });

  @override
  Widget build(BuildContext context) => _InheritedTheme(
        data: data,
        child: Directionality(
          textDirection: textDirection ?? Directionality.maybeOf(context) ?? TextDirection.ltr,
          child: DefaultTextStyle(
            style: data.typography.base.copyWith(
              fontFamily: data.typography.defaultFontFamily,
              color: data.colorScheme.foreground,
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

class _InheritedTheme extends InheritedWidget {
  final FThemeData data;

  const _InheritedTheme({required this.data, required super.child});

  @override
  bool updateShouldNotify(covariant _InheritedTheme old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}

/// Provides functions for accessing the current [FThemeData].
extension ThemeBuildContext on BuildContext {
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
