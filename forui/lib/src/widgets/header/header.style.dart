// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FHeaderStylesCopyWith on FHeaderStyles {
  /// Returns a copy of this [FHeaderStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [rootStyle]
  /// The root header's style.
  ///
  /// # [nestedStyle]
  /// The nested header's style.
  ///
  @useResult
  FHeaderStyles copyWith({
    FHeaderStyle Function(FHeaderStyle)? rootStyle,
    FHeaderStyle Function(FHeaderStyle)? nestedStyle,
  }) => FHeaderStyles(
    rootStyle: rootStyle != null ? rootStyle(this.rootStyle) : this.rootStyle,
    nestedStyle: nestedStyle != null ? nestedStyle(this.nestedStyle) : this.nestedStyle,
  );
}

/// Provides a `copyWith` method.
extension $FHeaderStyleCopyWith on FHeaderStyle {
  /// Returns a copy of this [FHeaderStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [systemOverlayStyle]
  /// The system overlay style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [backgroundFilter]
  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  ///
  /// # [padding]
  /// The padding.
  ///
  /// # [actionSpacing]
  /// The spacing between [FHeaderAction]s. Defaults to 10.
  ///
  /// # [titleTextStyle]
  /// The title's [TextStyle].
  ///
  /// # [actionStyle]
  /// The [FHeaderAction]s' style.
  ///
  @useResult
  FHeaderStyle copyWith({
    SystemUiOverlayStyle? systemOverlayStyle,
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    double? actionSpacing,
    TextStyle? titleTextStyle,
    FHeaderActionStyle Function(FHeaderActionStyle)? actionStyle,
  }) => FHeaderStyle(
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    actionSpacing: actionSpacing ?? this.actionSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    actionStyle: actionStyle != null ? actionStyle(this.actionStyle) : this.actionStyle,
  );
}

/// Provides a `copyWith` method.
extension $FHeaderActionStyleCopyWith on FHeaderActionStyle {
  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  ///
  /// # [focusedOutlineStyle]
  /// The outline style when this action is focused.
  ///
  /// # [tappableStyle]
  /// The tappable's style.
  ///
  @useResult
  FHeaderActionStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
  }) => FHeaderActionStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );
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
      ..add(DiagnosticsProperty('rootStyle', rootStyle))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyles && rootStyle == other.rootStyle && nestedStyle == other.nestedStyle);
  @override
  int get hashCode => rootStyle.hashCode ^ nestedStyle.hashCode;
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
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('actionSpacing', actionSpacing))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('actionStyle', actionStyle));
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
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
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
