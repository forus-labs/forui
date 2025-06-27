// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSidebarStyleCopyWith on FSidebarStyle {
  /// Returns a copy of this [FSidebarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [backgroundFilter]
  /// An optional background filter applied to the sidebar.
  ///
  /// This is typically combined with a translucent background in [decoration] to create a glassmorphic effect.
  ///
  /// # [constraints]
  /// The sidebar's width. Defaults to `BoxConstraints.tightFor(width: 250)`.
  ///
  /// # [groupStyle]
  /// The group's style.
  ///
  /// # [headerPadding]
  /// The padding for the header section. Defaults to `EdgeInsets.fromLTRB(0, 16, 0, 0)`.
  ///
  /// It is recommended to set the horizontal padding to 0. This ensures that the elements such as the scrollbar is not
  /// overlapped by the content.
  ///
  /// # [contentPadding]
  /// The padding for the content section. Defaults to `EdgeInsets.symmetric(vertical: 12)`.
  ///
  /// It is recommended to set the horizontal padding to 0. This ensures that the elements such as the scrollbar is not
  /// overlapped by the content.
  ///
  /// # [footerPadding]
  /// The padding for the footer section. Defaults to `EdgeInsets.fromLTRB(0, 0, 0, 16)`.
  ///
  /// It is recommended to set the horizontal padding to 0. This ensures that the elements such as the scrollbar is not
  /// overlapped by the content.
  ///
  @useResult
  FSidebarStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    BoxConstraints? constraints,
    FSidebarGroupStyle Function(FSidebarGroupStyle)? groupStyle,
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
