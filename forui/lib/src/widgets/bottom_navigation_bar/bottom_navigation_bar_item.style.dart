// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FBottomNavigationBarItemStyleCopyWith on FBottomNavigationBarItemStyle {
  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [textStyle]
  /// The text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.all(5)`.
  ///
  /// # [spacing]
  /// The spacing between the icon and the label. Defaults to 2.
  ///
  /// # [tappableStyle]
  /// The item's tappable's style.
  ///
  /// # [focusedOutlineStyle]
  /// The item's focused outline style.
  ///
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<TextStyle>? textStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FBottomNavigationBarItemStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    textStyle: textStyle ?? this.textStyle,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );
}

mixin _$FBottomNavigationBarItemStyleFunctions on Diagnosticable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  FWidgetStateMap<TextStyle> get textStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FBottomNavigationBarItemStyle] to replace functions that accept and return a [FBottomNavigationBarItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBottomNavigationBarItemStyle Function(FBottomNavigationBarItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBottomNavigationBarItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBottomNavigationBarItemStyle(...));
  /// ```
  @useResult
  FBottomNavigationBarItemStyle call(Object? _) => this as FBottomNavigationBarItemStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarItemStyle &&
          iconStyle == other.iconStyle &&
          textStyle == other.textStyle &&
          padding == other.padding &&
          spacing == other.spacing &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      iconStyle.hashCode ^
      textStyle.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
