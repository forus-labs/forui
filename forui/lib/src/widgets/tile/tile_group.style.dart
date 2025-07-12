// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile_group.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTileGroupStyleCopyWith on FTileGroupStyle {
  /// Returns a copy of this [FTileGroupStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The group's decoration.
  ///
  /// # [tileStyle]
  /// The tile's style.
  ///
  /// # [dividerColor]
  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  ///
  /// # [dividerWidth]
  /// The divider's width.
  ///
  /// # [labelPadding]
  /// The label's padding.
  ///
  /// # [descriptionPadding]
  /// The description's padding.
  ///
  /// # [errorPadding]
  /// The error's padding.
  ///
  /// # [childPadding]
  /// The child's padding.
  ///
  /// # [labelTextStyle]
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [descriptionTextStyle]
  /// The description's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [errorTextStyle]
  /// The error's text style.
  ///
  @useResult
  FTileGroupStyle copyWith({
    BoxDecoration? decoration,
    FTileStyle Function(FTileStyle)? tileStyle,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FTileGroupStyle(
    decoration: decoration ?? this.decoration,
    tileStyle: tileStyle != null ? tileStyle(this.tileStyle) : this.tileStyle,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );
}

mixin _$FTileGroupStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  FTileStyle get tileStyle;
  FWidgetStateMap<Color> get dividerColor;
  double get dividerWidth;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FTileGroupStyle] to replace functions that accept and return a [FTileGroupStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTileGroupStyle Function(FTileGroupStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTileGroupStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTileGroupStyle(...));
  /// ```
  @useResult
  FTileGroupStyle call(Object? _) => this as FTileGroupStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('tileStyle', tileStyle))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding))
      ..add(DiagnosticsProperty('errorPadding', errorPadding))
      ..add(DiagnosticsProperty('childPadding', childPadding))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileGroupStyle &&
          decoration == other.decoration &&
          tileStyle == other.tileStyle &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      tileStyle.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}
