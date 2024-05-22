import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// Represents a ForUI theme.
class FTheme extends StatelessWidget {
  /// Retrieves the theme data.
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
      child: child,
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
