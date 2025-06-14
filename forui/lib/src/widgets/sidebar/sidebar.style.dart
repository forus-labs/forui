// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSidebarStyleFunctions on Diagnosticable implements FTransformable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  BoxConstraints get constraints;
  FSidebarGroupStyle get groupStyle;
  EdgeInsetsGeometry get headerPadding;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get footerPadding;

  /// Returns a copy of this [FSidebarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSidebarStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    BoxConstraints? constraints,
    FSidebarGroupStyle? groupStyle,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? footerPadding,
  }) => FSidebarStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    constraints: constraints ?? this.constraints,
    groupStyle: groupStyle ?? this.groupStyle,
    headerPadding: headerPadding ?? this.headerPadding,
    contentPadding: contentPadding ?? this.contentPadding,
    footerPadding: footerPadding ?? this.footerPadding,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('groupStyle', groupStyle))
      ..add(DiagnosticsProperty('headerPadding', headerPadding))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('footerPadding', footerPadding));
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
