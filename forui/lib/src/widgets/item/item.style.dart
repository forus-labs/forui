// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FItemStyleCopyWith on FItemStyle {
  /// Returns a copy of this [FItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [backgroundColor]
  /// The item's background color.
  ///
  /// It is applied to the entire item, including [margin]. Since it is applied before [decoration] in the z-layer,
  /// it is not visible if [decoration] has a background color.
  ///
  /// This is useful for setting a background color when [margin] is not zero.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  ///
  /// # [margin]
  /// The margin around the item, including the [decoration].
  ///
  /// Defaults to `const EdgeInsets.symmetric(vertical: 2, horizontal: 4)`.
  ///
  /// # [decoration]
  /// The item's decoration.
  ///
  /// An [FItem] is considered tappable if [FItem.onPress] or [FItem.onLongPress] is not null.
  ///
  /// The supported states if the item is tappable:
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.disabled]
  ///
  /// The supported states if the item is untappable:
  /// * [WidgetState.disabled]
  ///
  /// # [contentStyle]
  /// The default item content's style.
  ///
  /// # [rawItemContentStyle]
  /// THe default raw item content's style.
  ///
  /// # [tappableStyle]
  /// The tappable style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  @useResult
  FItemStyle copyWith({
    FWidgetStateMap<Color?>? backgroundColor,
    EdgeInsetsGeometry? margin,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FItemContentStyle Function(FItemContentStyle)? contentStyle,
    FRawItemContentStyle Function(FRawItemContentStyle)? rawItemContentStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
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
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('rawItemContentStyle', rawItemContentStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
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
