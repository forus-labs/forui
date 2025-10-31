// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FButtonStyleTransformations on FButtonStyle {
  /// Returns a copy of this [FButtonStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonStyle.decoration] - The box decoration.
  /// * [FButtonStyle.contentStyle] - The content's style.
  /// * [FButtonStyle.iconContentStyle] - The icon content's style.
  /// * [FButtonStyle.tappableStyle] - The tappable's style.
  /// * [FButtonStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FButtonStyle copyWith({
    FWidgetStateMap<BoxDecoration>? decoration,
    FButtonContentStyle Function(FButtonContentStyle style)? contentStyle,
    FButtonIconContentStyle Function(FButtonIconContentStyle style)? iconContentStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => FButtonStyle(
    decoration: decoration ?? this.decoration,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    iconContentStyle: iconContentStyle != null ? iconContentStyle(this.iconContentStyle) : this.iconContentStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FButtonStyle] using the given factor [t].
  @useResult
  FButtonStyle lerp(FButtonStyle other, double t) => FButtonStyle(
    decoration: FWidgetStateMap.lerpBoxDecoration(decoration, other.decoration, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    iconContentStyle: iconContentStyle.lerp(other.iconContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FButtonStyleFunctions on Diagnosticable {
  FWidgetStateMap<BoxDecoration> get decoration;
  FButtonContentStyle get contentStyle;
  FButtonIconContentStyle get iconContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FButtonStyle] to replace functions that accept and return a [FButtonStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonStyle Function(FButtonStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonStyle(...));
  /// ```
  @useResult
  FButtonStyle call(Object? _) => this as FButtonStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconContentStyle', iconContentStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonStyle &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          iconContentStyle == other.iconContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      contentStyle.hashCode ^
      iconContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
