import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// Represents a Forui theme.
///
/// See [ThemeBuildContext.theme] for accessing the current theme.
class FTheme extends StatelessWidget {

  /// Retrieves the current theme data.
  ///
  /// It is recommended to use [ThemeBuildContext.theme] to access the current theme instead.
  static FThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return theme?.data ?? FThemes.zinc.light;
  }

  /// The theme data.
  final FThemeData data;

  /// The child widget.
  final Widget child;

  /// The text direction.
  ///
  /// If none is provided, the text direction is inherited from the context.
  final TextDirection? textDirection;

  /// Creates a [FTheme].
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
      textDirection: textDirection ?? Directionality.of(context),
      child: DefaultTextStyle(
        // TODO: replace with configurable default font.
        style: data.font.toTextStyle(
          fontSize: 10,
          color: data.colorScheme.foreground,
        ),
        child: child,
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FThemeData>('data', data, showName: false));
  }

}

class _InheritedTheme extends InheritedWidget {
  final FThemeData data;

  const _InheritedTheme({required this.data, required super.child});

  @override
  bool updateShouldNotify(covariant _InheritedTheme old) => data != old.data;
}

/// Provides functions for accessing the current [FThemeData].
extension ThemeBuildContext on BuildContext {

  /// Retrieves the current [FThemeData] from an ancestor [FTheme]. Defaults to [FThemes.zinc.light] if there is no
  /// ancestor [FTheme].
  FThemeData get theme {
    final theme = dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return theme?.data ?? FThemes.zinc.light;
  }

}
