part of 'alert.dart';

/// [FAlertCustomStyle]'s style.
class FAlertStyles with Diagnosticable {
  /// The primary alert style.
  final FAlertCustomStyle primary;

  /// The destructive alert style.
  final FAlertCustomStyle destructive;

  /// Creates a [FAlertStyles].
  const FAlertStyles({
    required this.primary,
    required this.destructive,
  });

  /// Creates a [FAlertStyles] that inherits its properties from the provided [colorScheme], [typography], and
  /// [style].
  FAlertStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : primary = FAlertCustomStyle(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            titleTextStyle: typography.base.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.foreground,
              height: 1.2,
            ),
            subtitleTextStyle: typography.sm.copyWith(color: colorScheme.foreground),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.border),
              borderRadius: style.borderRadius,
              color: colorScheme.background,
            ),
            icon: FAlertIconStyle(color: colorScheme.foreground)),
        destructive = FAlertCustomStyle(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          titleTextStyle: typography.base.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.destructive,
            height: 1.2,
          ),
          subtitleTextStyle: typography.sm.copyWith(color: colorScheme.destructive),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.destructive),
            borderRadius: style.borderRadius,
            color: colorScheme.background,
          ),
          icon: FAlertIconStyle(color: colorScheme.destructive),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('destructive', destructive));
  }

  /// Returns a copy of this [FAlertStyles] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FAlertStyles(
  ///   primary: ...,
  ///   destructive: ...,
  /// );
  ///
  /// final copy = style.copyWith(destructive: ...);
  ///
  /// print(style.primary == copy.primary); // true
  /// print(style.destructive == copy.destructive); // false
  /// ```
  @useResult
  FAlertStyles copyWith({
    FAlertCustomStyle? primary,
    FAlertCustomStyle? destructive,
  }) =>
      FAlertStyles(
        primary: primary ?? this.primary,
        destructive: destructive ?? this.destructive,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAlertStyles &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          destructive == other.destructive;

  @override
  int get hashCode => primary.hashCode ^ destructive.hashCode;
}
