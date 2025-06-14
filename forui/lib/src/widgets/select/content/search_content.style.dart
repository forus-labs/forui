// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'search_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSelectSearchStyleFunctions on Diagnosticable implements FTransformable {
  FTextFieldStyle get textFieldStyle;
  IconThemeData get iconStyle;
  FDividerStyle get dividerStyle;
  IconThemeData get loadingIndicatorStyle;

  /// Returns a copy of this [FSelectSearchStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSelectSearchStyle copyWith({
    FTextFieldStyle? textFieldStyle,
    IconThemeData? iconStyle,
    FDividerStyle? dividerStyle,
    IconThemeData? loadingIndicatorStyle,
  }) => FSelectSearchStyle(
    textFieldStyle: textFieldStyle ?? this.textFieldStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    dividerStyle: dividerStyle ?? this.dividerStyle,
    loadingIndicatorStyle: loadingIndicatorStyle ?? this.loadingIndicatorStyle,
  );
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
