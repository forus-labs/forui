// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'label.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FLabelStylesTransformations on FLabelStyles {
  /// Returns a copy of this [FLabelStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FLabelStyles.horizontalStyle] - The horizontal label's style.
  /// * [FLabelStyles.verticalStyle] - The vertical label's style.
  @useResult
  FLabelStyles copyWith({
    FLabelStyle Function(FLabelStyle style)? horizontalStyle,
    FLabelStyle Function(FLabelStyle style)? verticalStyle,
  }) => FLabelStyles(
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );

  /// Linearly interpolate between this and another [FLabelStyles] using the given factor [t].
  @useResult
  FLabelStyles lerp(FLabelStyles other, double t) => FLabelStyles(
    horizontalStyle: horizontalStyle.lerp(other.horizontalStyle, t),
    verticalStyle: verticalStyle.lerp(other.verticalStyle, t),
  );
}

mixin _$FLabelStylesFunctions on Diagnosticable {
  FLabelStyle get horizontalStyle;
  FLabelStyle get verticalStyle;

  /// Returns itself.
  ///
  /// Allows [FLabelStyles] to replace functions that accept and return a [FLabelStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FLabelStyles Function(FLabelStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FLabelStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FLabelStyles(...));
  /// ```
  @useResult
  FLabelStyles call(Object? _) => this as FLabelStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLabelStyles && horizontalStyle == other.horizontalStyle && verticalStyle == other.verticalStyle);

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FLabelStyleTransformations on FLabelStyle {
  /// Returns a copy of this [FLabelStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FLabelStyle.labelPadding] - The label's padding.
  /// * [FLabelStyle.descriptionPadding] - The description's padding.
  /// * [FLabelStyle.errorPadding] - The error's padding.
  /// * [FLabelStyle.childPadding] - The child's padding.
  /// * [FLabelStyle.labelTextStyle] - The label's text style.
  /// * [FLabelStyle.descriptionTextStyle] - The description's text style.
  /// * [FLabelStyle.errorTextStyle] - The error's text style.
  @useResult
  FLabelStyle copyWith({
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FLabelStyle(
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FLabelStyle] using the given factor [t].
  @useResult
  FLabelStyle lerp(FLabelStyle other, double t) => FLabelStyle(
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FLabelStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FLabelStyle] to replace functions that accept and return a [FLabelStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FLabelStyle Function(FLabelStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FLabelStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FLabelStyle(...));
  /// ```
  @useResult
  FLabelStyle call(Object? _) => this as FLabelStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
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
      (other is FLabelStyle &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}
