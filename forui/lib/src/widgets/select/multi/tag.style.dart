// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tag.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FMultiSelectTagStyleCopyWith on FMultiSelectTagStyle {
  /// Returns a copy of this [FMultiSelectTagStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.symmetric(vertical: 4, horizontal: 8)`.
  ///
  /// The vertical padding should typically be the same as the [FMultiSelectFieldStyle.hintPadding].
  ///
  /// # [spacing]
  /// The spacing between the label and the icon. Defaults to 4.
  ///
  /// # [labelTextStyle]
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  ///
  /// # [tappableStyle]
  /// The tappable style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  @useResult
  FMultiSelectTagStyle copyWith({
    FWidgetStateMap<Decoration>? decoration,
    EdgeInsets? padding,
    double? spacing,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FMultiSelectTagStyle(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );
}

mixin _$FMultiSelectTagStyleFunctions on Diagnosticable {
  FWidgetStateMap<Decoration> get decoration;
  EdgeInsets get padding;
  double get spacing;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FMultiSelectTagStyle] to replace functions that accept and return a [FMultiSelectTagStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FMultiSelectTagStyle Function(FMultiSelectTagStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FMultiSelectTagStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FMultiSelectTagStyle(...));
  /// ```
  @useResult
  FMultiSelectTagStyle call(Object? _) => this as FMultiSelectTagStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectTagStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          spacing == other.spacing &&
          labelTextStyle == other.labelTextStyle &&
          iconStyle == other.iconStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      labelTextStyle.hashCode ^
      iconStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
