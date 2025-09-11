// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarStyleTransformations on FSidebarStyle {
  /// Returns a copy of this [FSidebarStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarStyle.decoration] - The decoration.
  /// * [FSidebarStyle.backgroundFilter] - An optional background filter applied to the sidebar.
  /// * [FSidebarStyle.constraints] - The sidebar's width.
  /// * [FSidebarStyle.groupStyle] - The group's style.
  /// * [FSidebarStyle.headerPadding] - The padding for the header section.
  /// * [FSidebarStyle.contentPadding] - The padding for the content section.
  /// * [FSidebarStyle.footerPadding] - The padding for the footer section.
  @useResult
  FSidebarStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    BoxConstraints? constraints,
    FSidebarGroupStyle Function(FSidebarGroupStyle style)? groupStyle,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? footerPadding,
  }) => FSidebarStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    constraints: constraints ?? this.constraints,
    groupStyle: groupStyle != null ? groupStyle(this.groupStyle) : this.groupStyle,
    headerPadding: headerPadding ?? this.headerPadding,
    contentPadding: contentPadding ?? this.contentPadding,
    footerPadding: footerPadding ?? this.footerPadding,
  );

  /// Linearly interpolate between this and another [FSidebarStyle] using the given factor [t].
  @useResult
  FSidebarStyle lerp(FSidebarStyle other, double t) => FSidebarStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    constraints: BoxConstraints.lerp(constraints, other.constraints, t) ?? constraints,
    groupStyle: groupStyle.lerp(other.groupStyle, t),
    headerPadding: EdgeInsetsGeometry.lerp(headerPadding, other.headerPadding, t) ?? headerPadding,
    contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    footerPadding: EdgeInsetsGeometry.lerp(footerPadding, other.footerPadding, t) ?? footerPadding,
  );
}

mixin _$FSidebarStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  BoxConstraints get constraints;
  FSidebarGroupStyle get groupStyle;
  EdgeInsetsGeometry get headerPadding;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get footerPadding;

  /// Returns itself.
  ///
  /// Allows [FSidebarStyle] to replace functions that accept and return a [FSidebarStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSidebarStyle Function(FSidebarStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSidebarStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSidebarStyle(...));
  /// ```
  @useResult
  FSidebarStyle call(Object? _) => this as FSidebarStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('constraints', constraints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('groupStyle', groupStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('headerPadding', headerPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('footerPadding', footerPadding, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          constraints == other.constraints &&
          groupStyle == other.groupStyle &&
          headerPadding == other.headerPadding &&
          contentPadding == other.contentPadding &&
          footerPadding == other.footerPadding);

  @override
  int get hashCode =>
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      constraints.hashCode ^
      groupStyle.hashCode ^
      headerPadding.hashCode ^
      contentPadding.hashCode ^
      footerPadding.hashCode;
}
