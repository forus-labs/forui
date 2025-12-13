// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tabs.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTabMotionTransformations on FTabMotion {
  /// Returns a copy of this [FTabMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FTabMotion.duration] - The duration of the tab change animation.
  /// * [FTabMotion.curve] - The curve of the tab change animation.
  @useResult
  FTabMotion copyWith({Duration? duration, Curve? curve}) =>
      .new(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FTabMotion] using the given factor [t].
  @useResult
  FTabMotion lerp(FTabMotion other, double t) =>
      .new(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FTabMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FTabMotion call(Object? _) => this as FTabMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTabMotion && runtimeType == other.runtimeType && duration == other.duration && curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FTabsStyleTransformations on FTabsStyle {
  /// Returns a copy of this [FTabsStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTabsStyle.decoration] - The decoration.
  /// * [FTabsStyle.padding] - The padding.
  /// * [FTabsStyle.selectedLabelTextStyle] - The [TextStyle] of the label.
  /// * [FTabsStyle.unselectedLabelTextStyle] - The [TextStyle] of the label.
  /// * [FTabsStyle.indicatorDecoration] - The indicator.
  /// * [FTabsStyle.indicatorSize] - The indicator size.
  /// * [FTabsStyle.height] - The height.
  /// * [FTabsStyle.spacing] - The spacing between the tab bar and the views.
  /// * [FTabsStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FTabsStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    TextStyle? selectedLabelTextStyle,
    TextStyle? unselectedLabelTextStyle,
    BoxDecoration? indicatorDecoration,
    FTabBarIndicatorSize? indicatorSize,
    double? height,
    double? spacing,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => .new(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    selectedLabelTextStyle: selectedLabelTextStyle ?? this.selectedLabelTextStyle,
    unselectedLabelTextStyle: unselectedLabelTextStyle ?? this.unselectedLabelTextStyle,
    indicatorDecoration: indicatorDecoration ?? this.indicatorDecoration,
    indicatorSize: indicatorSize ?? this.indicatorSize,
    height: height ?? this.height,
    spacing: spacing ?? this.spacing,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FTabsStyle] using the given factor [t].
  @useResult
  FTabsStyle lerp(FTabsStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
    selectedLabelTextStyle: .lerp(selectedLabelTextStyle, other.selectedLabelTextStyle, t) ?? selectedLabelTextStyle,
    unselectedLabelTextStyle:
        .lerp(unselectedLabelTextStyle, other.unselectedLabelTextStyle, t) ?? unselectedLabelTextStyle,
    indicatorDecoration: .lerp(indicatorDecoration, other.indicatorDecoration, t) ?? indicatorDecoration,
    indicatorSize: t < 0.5 ? indicatorSize : other.indicatorSize,
    height: lerpDouble(height, other.height, t) ?? height,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FTabsStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  TextStyle get selectedLabelTextStyle;
  TextStyle get unselectedLabelTextStyle;
  BoxDecoration get indicatorDecoration;
  FTabBarIndicatorSize get indicatorSize;
  double get height;
  double get spacing;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FTabsStyle] to replace functions that accept and return a [FTabsStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTabsStyle Function(FTabsStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTabsStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTabsStyle(...));
  /// ```
  @useResult
  FTabsStyle call(Object? _) => this as FTabsStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('selectedLabelTextStyle', selectedLabelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('unselectedLabelTextStyle', unselectedLabelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('indicatorDecoration', indicatorDecoration, level: .debug))
      ..add(EnumProperty('indicatorSize', indicatorSize, level: .debug))
      ..add(DoubleProperty('height', height, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTabsStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          selectedLabelTextStyle == other.selectedLabelTextStyle &&
          unselectedLabelTextStyle == other.unselectedLabelTextStyle &&
          indicatorDecoration == other.indicatorDecoration &&
          indicatorSize == other.indicatorSize &&
          height == other.height &&
          spacing == other.spacing &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      selectedLabelTextStyle.hashCode ^
      unselectedLabelTextStyle.hashCode ^
      indicatorDecoration.hashCode ^
      indicatorSize.hashCode ^
      height.hashCode ^
      spacing.hashCode ^
      focusedOutlineStyle.hashCode;
}
