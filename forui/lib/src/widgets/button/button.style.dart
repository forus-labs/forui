// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FButtonStyleCopyWith on FButtonStyle {
  /// Returns a copy of this [FButtonStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The box decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [contentStyle]
  /// The content's style.
  ///
  /// # [iconContentStyle]
  /// The icon content's style.
  ///
  /// # [tappableStyle]
  /// The tappable's style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  @useResult
  FButtonStyle copyWith({
    FWidgetStateMap<BoxDecoration>? decoration,
    FButtonContentStyle Function(FButtonContentStyle)? contentStyle,
    FButtonIconContentStyle Function(FButtonIconContentStyle)? iconContentStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FButtonStyle(
    decoration: decoration ?? this.decoration,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    iconContentStyle: iconContentStyle != null ? iconContentStyle(this.iconContentStyle) : this.iconContentStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );
}

mixin _$FButtonStyleFunctions on Diagnosticable {
  FWidgetStateMap<BoxDecoration> get decoration;
  FButtonContentStyle get contentStyle;
  FButtonIconContentStyle get iconContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FButtonStyle] to replace functions that accept and return a [FButtonStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonStyle Function(FButtonStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonStyle(...));
  /// ```
  @useResult
  FButtonStyle call(Object? _) => this as FButtonStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('iconContentStyle', iconContentStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonStyle &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          iconContentStyle == other.iconContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      contentStyle.hashCode ^
      iconContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
