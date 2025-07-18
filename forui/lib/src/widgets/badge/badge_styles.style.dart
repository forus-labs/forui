// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_styles.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FBadgeStylesCopyWith on FBadgeStyles {
  /// Returns a copy of this [FBadgeStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [primary]
  /// The primary badge style.
  ///
  /// # [secondary]
  /// The secondary badge style.
  ///
  /// # [outline]
  /// The outlined badge style.
  ///
  /// # [destructive]
  /// The destructive badge style.
  ///
  @useResult
  FBadgeStyles copyWith({
    FBadgeStyle Function(FBadgeStyle)? primary,
    FBadgeStyle Function(FBadgeStyle)? secondary,
    FBadgeStyle Function(FBadgeStyle)? outline,
    FBadgeStyle Function(FBadgeStyle)? destructive,
  }) => FBadgeStyles(
    primary: primary != null ? primary(this.primary) : this.primary,
    secondary: secondary != null ? secondary(this.secondary) : this.secondary,
    outline: outline != null ? outline(this.outline) : this.outline,
    destructive: destructive != null ? destructive(this.destructive) : this.destructive,
  );
}

mixin _$FBadgeStylesFunctions on Diagnosticable {
  FBadgeStyle get primary;
  FBadgeStyle get secondary;
  FBadgeStyle get outline;
  FBadgeStyle get destructive;

  /// Returns itself.
  ///
  /// Allows [FBadgeStyles] to replace functions that accept and return a [FBadgeStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBadgeStyles Function(FBadgeStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBadgeStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBadgeStyles(...));
  /// ```
  @useResult
  FBadgeStyles call(Object? _) => this as FBadgeStyles;
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
      (other is FBadgeStyles &&
          primary == other.primary &&
          secondary == other.secondary &&
          outline == other.outline &&
          destructive == other.destructive);
  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ outline.hashCode ^ destructive.hashCode;
}
