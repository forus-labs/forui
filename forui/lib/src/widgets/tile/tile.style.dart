// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTileStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<BoxDecoration> get decoration;
  FWidgetStateMap<FDividerStyle> get dividerStyle;
  FTileContentStyle get contentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FTileStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FTileStyle copyWith({
    FWidgetStateMap<BoxDecoration>? decoration,
    FWidgetStateMap<FDividerStyle>? dividerStyle,
    FTileContentStyle? contentStyle,
    FTappableStyle? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FTileStyle(
    decoration: decoration ?? this.decoration,
    dividerStyle: dividerStyle ?? this.dividerStyle,
    contentStyle: contentStyle ?? this.contentStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileStyle &&
          decoration == other.decoration &&
          dividerStyle == other.dividerStyle &&
          contentStyle == other.contentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      dividerStyle.hashCode ^
      contentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
