// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderStylesTransformations on FHeaderStyles {
  /// Returns a copy of this [FHeaderStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderStyles.rootStyle] - The root header's style.
  /// * [FHeaderStyles.nestedStyle] - The nested header's style.
  @useResult
  FHeaderStyles copyWith({
    FHeaderStyle Function(FHeaderStyle style)? rootStyle,
    FHeaderStyle Function(FHeaderStyle style)? nestedStyle,
  }) => FHeaderStyles(
    rootStyle: rootStyle != null ? rootStyle(this.rootStyle) : this.rootStyle,
    nestedStyle: nestedStyle != null ? nestedStyle(this.nestedStyle) : this.nestedStyle,
  );

  /// Linearly interpolate between this and another [FHeaderStyles] using the given factor [t].
  @useResult
  FHeaderStyles lerp(FHeaderStyles other, double t) =>
      FHeaderStyles(rootStyle: rootStyle.lerp(other.rootStyle, t), nestedStyle: nestedStyle.lerp(other.nestedStyle, t));
}

mixin _$FHeaderStylesFunctions on Diagnosticable {
  FHeaderStyle get rootStyle;
  FHeaderStyle get nestedStyle;

  /// Returns itself.
  ///
  /// Allows [FHeaderStyles] to replace functions that accept and return a [FHeaderStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FHeaderStyles Function(FHeaderStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FHeaderStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FHeaderStyles(...));
  /// ```
  @useResult
  FHeaderStyles call(Object? _) => this as FHeaderStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('rootStyle', rootStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyles && rootStyle == other.rootStyle && nestedStyle == other.nestedStyle);

  @override
  int get hashCode => rootStyle.hashCode ^ nestedStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderStyleTransformations on FHeaderStyle {
  /// Returns a copy of this [FHeaderStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderStyle.systemOverlayStyle] - The system overlay style.
  /// * [FHeaderStyle.decoration] - The decoration.
  /// * [FHeaderStyle.backgroundFilter] - An optional background filter.
  /// * [FHeaderStyle.padding] - The padding.
  /// * [FHeaderStyle.actionSpacing] - The spacing between [FHeaderAction]s.
  /// * [FHeaderStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FHeaderStyle.actionStyle] - The [FHeaderAction]s' style.
  @useResult
  FHeaderStyle copyWith({
    SystemUiOverlayStyle? systemOverlayStyle,
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    double? actionSpacing,
    TextStyle? titleTextStyle,
    FHeaderActionStyle Function(FHeaderActionStyle style)? actionStyle,
  }) => FHeaderStyle(
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    actionSpacing: actionSpacing ?? this.actionSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    actionStyle: actionStyle != null ? actionStyle(this.actionStyle) : this.actionStyle,
  );

  /// Linearly interpolate between this and another [FHeaderStyle] using the given factor [t].
  @useResult
  FHeaderStyle lerp(FHeaderStyle other, double t) => FHeaderStyle(
    systemOverlayStyle: t < 0.5 ? systemOverlayStyle : other.systemOverlayStyle,
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
    titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    actionStyle: actionStyle.lerp(other.actionStyle, t),
  );
}

mixin _$FHeaderStyleFunctions on Diagnosticable {
  SystemUiOverlayStyle get systemOverlayStyle;
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  double get actionSpacing;
  TextStyle get titleTextStyle;
  FHeaderActionStyle get actionStyle;

  /// Returns itself.
  ///
  /// Allows [FHeaderStyle] to replace functions that accept and return a [FHeaderStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FHeaderStyle Function(FHeaderStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FHeaderStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FHeaderStyle(...));
  /// ```
  @useResult
  FHeaderStyle call(Object? _) => this as FHeaderStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('actionSpacing', actionSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('actionStyle', actionStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyle &&
          systemOverlayStyle == other.systemOverlayStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          actionSpacing == other.actionSpacing &&
          titleTextStyle == other.titleTextStyle &&
          actionStyle == other.actionStyle);

  @override
  int get hashCode =>
      systemOverlayStyle.hashCode ^
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      actionSpacing.hashCode ^
      titleTextStyle.hashCode ^
      actionStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderActionStyleTransformations on FHeaderActionStyle {
  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderActionStyle.iconStyle] - The icon's style.
  /// * [FHeaderActionStyle.focusedOutlineStyle] - The outline style when this action is focused.
  /// * [FHeaderActionStyle.tappableStyle] - The tappable's style.
  @useResult
  FHeaderActionStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
  }) => FHeaderActionStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FHeaderActionStyle] using the given factor [t].
  @useResult
  FHeaderActionStyle lerp(FHeaderActionStyle other, double t) => FHeaderActionStyle(
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FHeaderActionStyleFunctions on Diagnosticable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FHeaderActionStyle] to replace functions that accept and return a [FHeaderActionStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FHeaderActionStyle Function(FHeaderActionStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FHeaderActionStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FHeaderActionStyle(...));
  /// ```
  @useResult
  FHeaderActionStyle call(Object? _) => this as FHeaderActionStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderActionStyle &&
          iconStyle == other.iconStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode => iconStyle.hashCode ^ focusedOutlineStyle.hashCode ^ tappableStyle.hashCode;
}
