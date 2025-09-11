// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_menu_tile.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectMenuTileStyleTransformations on FSelectMenuTileStyle {
  /// Returns a copy of this [FSelectMenuTileStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectMenuTileStyle.menuStyle] - The menu's style.
  /// * [FSelectMenuTileStyle.tileStyle] - The tile's style.
  /// * [FSelectMenuTileStyle.labelPadding] - The label's padding.
  /// * [FSelectMenuTileStyle.descriptionPadding] - The description's padding.
  /// * [FSelectMenuTileStyle.errorPadding] - The error's padding.
  /// * [FSelectMenuTileStyle.childPadding] - The child's padding.
  /// * [FSelectMenuTileStyle.labelTextStyle] - The label's text style.
  /// * [FSelectMenuTileStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectMenuTileStyle.errorTextStyle] - The error's text style.
  @useResult
  FSelectMenuTileStyle copyWith({
    FPopoverMenuStyle Function(FPopoverMenuStyle style)? menuStyle,
    FTileStyle Function(FTileStyle style)? tileStyle,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FSelectMenuTileStyle(
    menuStyle: menuStyle != null ? menuStyle(this.menuStyle) : this.menuStyle,
    tileStyle: tileStyle != null ? tileStyle(this.tileStyle) : this.tileStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectMenuTileStyle] using the given factor [t].
  @useResult
  FSelectMenuTileStyle lerp(FSelectMenuTileStyle other, double t) => FSelectMenuTileStyle(
    menuStyle: menuStyle.lerp(other.menuStyle, t),
    tileStyle: tileStyle.lerp(other.tileStyle, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FSelectMenuTileStyleFunctions on Diagnosticable {
  FPopoverMenuStyle get menuStyle;
  FTileStyle get tileStyle;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectMenuTileStyle] to replace functions that accept and return a [FSelectMenuTileStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectMenuTileStyle Function(FSelectMenuTileStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectMenuTileStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectMenuTileStyle(...));
  /// ```
  @useResult
  FSelectMenuTileStyle call(Object? _) => this as FSelectMenuTileStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('menuStyle', menuStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tileStyle', tileStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorPadding', errorPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectMenuTileStyle &&
          menuStyle == other.menuStyle &&
          tileStyle == other.tileStyle &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      menuStyle.hashCode ^
      tileStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}
