// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'search_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSelectSearchStyleCopyWith on FSelectSearchStyle {
  /// Returns a copy of this [FSelectSearchStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [textFieldStyle]
  /// The search field's style.
  ///
  /// # [iconStyle]
  /// The search icon's style.
  ///
  /// # [dividerStyle]
  /// The style of the divider between the search field and results.
  ///
  /// # [loadingIndicatorStyle]
  /// The loading indicators style.
  ///
  @useResult
  FSelectSearchStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle)? textFieldStyle,
    IconThemeData? iconStyle,
    FDividerStyle Function(FDividerStyle)? dividerStyle,
    IconThemeData? loadingIndicatorStyle,
  }) => FSelectSearchStyle(
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    dividerStyle: dividerStyle != null ? dividerStyle(this.dividerStyle) : this.dividerStyle,
    loadingIndicatorStyle: loadingIndicatorStyle ?? this.loadingIndicatorStyle,
  );
}

mixin _$FSelectSearchStyleFunctions on Diagnosticable {
  FTextFieldStyle get textFieldStyle;
  IconThemeData get iconStyle;
  FDividerStyle get dividerStyle;
  IconThemeData get loadingIndicatorStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectSearchStyle] to replace functions that accept and return a [FSelectSearchStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectSearchStyle Function(FSelectSearchStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectSearchStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectSearchStyle(...));
  /// ```
  @useResult
  FSelectSearchStyle call(Object? _) => this as FSelectSearchStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('loadingIndicatorStyle', loadingIndicatorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSearchStyle &&
          textFieldStyle == other.textFieldStyle &&
          iconStyle == other.iconStyle &&
          dividerStyle == other.dividerStyle &&
          loadingIndicatorStyle == other.loadingIndicatorStyle);
  @override
  int get hashCode =>
      textFieldStyle.hashCode ^ iconStyle.hashCode ^ dividerStyle.hashCode ^ loadingIndicatorStyle.hashCode;
}
