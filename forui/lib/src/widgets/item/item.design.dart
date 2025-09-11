// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FItemStyleTransformations on FItemStyle {
  /// Returns a copy of this [FItemStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemStyle.backgroundColor] - The item's background color.
  /// * [FItemStyle.margin] - The margin around the item, including the [decoration].
  /// * [FItemStyle.decoration] - The item's decoration.
  /// * [FItemStyle.contentStyle] - The default item content's style.
  /// * [FItemStyle.rawItemContentStyle] - THe default raw item content's style.
  /// * [FItemStyle.tappableStyle] - The tappable style.
  /// * [FItemStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FItemStyle copyWith({
    FWidgetStateMap<Color?>? backgroundColor,
    EdgeInsetsGeometry? margin,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FItemContentStyle Function(FItemContentStyle style)? contentStyle,
    FRawItemContentStyle Function(FRawItemContentStyle style)? rawItemContentStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FItemStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    margin: margin ?? this.margin,
    decoration: decoration ?? this.decoration,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    rawItemContentStyle: rawItemContentStyle != null
        ? rawItemContentStyle(this.rawItemContentStyle)
        : this.rawItemContentStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FItemStyle] using the given factor [t].
  @useResult
  FItemStyle lerp(FItemStyle other, double t) => FItemStyle(
    backgroundColor: FWidgetStateMap.lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) ?? margin,
    decoration: FWidgetStateMap.lerpWhere(decoration, other.decoration, t, BoxDecoration.lerp),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawItemContentStyle: rawItemContentStyle.lerp(other.rawItemContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
  );
}

mixin _$FItemStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color?> get backgroundColor;
  EdgeInsetsGeometry get margin;
  FWidgetStateMap<BoxDecoration?> get decoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawItemContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FItemStyle] to replace functions that accept and return a [FItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FItemStyle Function(FItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FItemStyle(...));
  /// ```
  @useResult
  FItemStyle call(Object? _) => this as FItemStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('margin', margin, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('rawItemContentStyle', rawItemContentStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemStyle &&
          backgroundColor == other.backgroundColor &&
          margin == other.margin &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          rawItemContentStyle == other.rawItemContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      margin.hashCode ^
      decoration.hashCode ^
      contentStyle.hashCode ^
      rawItemContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
