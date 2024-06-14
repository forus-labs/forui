part of 'badge.dart';

/// The [FBadgeStyle]s.
class FBadgeStyles with Diagnosticable {
  /// The primary badge style.
  final FBadgeStyle primary;

  /// The secondary badge style.
  final FBadgeStyle secondary;

  /// The outlined badge style.
  final FBadgeStyle outline;

  /// The destructive badge style.
  final FBadgeStyle destructive;

  /// Creates a [FBadgeStyles].
  FBadgeStyles({required this.primary, required this.secondary, required this.outline, required this.destructive});

  /// Creates a [FBadgeStyles] that inherits its properties from [colorScheme] and [style].
  FBadgeStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style}):
    primary = FBadgeStyle.inherit(
      style: style,
      background: colorScheme.primary,
      border: colorScheme.primary,
      content: FBadgeContentStyle(
        label: TextStyle(
          color: colorScheme.primaryForeground,
          fontSize: typography.sm,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    secondary = FBadgeStyle.inherit(
      style: style,
      background: colorScheme.secondary,
      border: colorScheme.secondary,
      content: FBadgeContentStyle(
        label: TextStyle(
          color: colorScheme.secondaryForeground,
          fontSize: typography.sm,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outline = FBadgeStyle.inherit(
      style: style,
      background: colorScheme.background,
      border: colorScheme.border,
      content: FBadgeContentStyle(
        label: TextStyle(
          color: colorScheme.foreground,
          fontSize: typography.sm,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    destructive = FBadgeStyle.inherit(
      style: style,
      background: colorScheme.destructive,
      border: colorScheme.destructive,
      content: FBadgeContentStyle(
        label: TextStyle(
          color: colorScheme.destructiveForeground,
          fontSize: typography.sm,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

  /// Creates a copy of this [FBadgeStyles] with the given properties replaced.
  FBadgeStyles copyWith({
    FBadgeStyle? primary,
    FBadgeStyle? secondary,
    FBadgeStyle? outline,
    FBadgeStyle? destructive,
  }) => FBadgeStyles(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    outline: outline ?? this.outline,
    destructive: destructive ?? this.destructive,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('outline', outline))
      ..add(DiagnosticsProperty('destructive', destructive));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeStyles &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          secondary == other.secondary &&
          outline == other.outline &&
          destructive == other.destructive;

  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ outline.hashCode ^ destructive.hashCode;
}
