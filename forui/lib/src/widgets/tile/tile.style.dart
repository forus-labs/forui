// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTileStyleCopyWith on FTileStyle {
  /// Returns a copy of this [FTileStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  //// The tile's border.
  ///
  /// ## Note
  /// If wrapped in a [FTileGroup], the [BoxDecoration.border] and [BoxDecoration.borderRadius] are ignored. Configure
  /// [FTileGroupStyle] instead.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [dividerStyle]
  /// The divider's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [contentStyle]
  /// The default tile content's style.
  ///
  /// # [tappableStyle]
  /// The tappable style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  @useResult
  FTileStyle copyWith({
    FWidgetStateMap<BoxDecoration>? decoration,
    FWidgetStateMap<FDividerStyle>? dividerStyle,
    FTileContentStyle Function(FTileContentStyle)? contentStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FTileStyle(
    decoration: decoration ?? this.decoration,
    dividerStyle: dividerStyle ?? this.dividerStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );
}

mixin _$FTileStyleFunctions on Diagnosticable {
  FWidgetStateMap<BoxDecoration> get decoration;
  FWidgetStateMap<FDividerStyle> get dividerStyle;
  FTileContentStyle get contentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FTileStyle] to replace functions that accept and return a [FTileStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTileStyle Function(FTileStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTileStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTileStyle(...));
  /// ```
  @useResult
  FTileStyle call(Object? _) => this as FTileStyle;
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
