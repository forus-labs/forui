import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A slider's style.
final class FSliderStyle with Diagnosticable {
  /// The slider's active color.
  final Color activeColor;

  /// The slider inactive color.
  final Color inactiveColor;

  /// The slider's cross-axis extent. Defaults to 8.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if it is not positive.
  final double crossAxisExtent;

  /// The slider's border radius.
  final BorderRadius borderRadius;

  /// The slider marks' style.
  final FSliderMarkStyle markStyle;

  /// The slider thumb's style.
  final FSliderThumbStyle thumbStyle;

  // TODO: tooltip style?

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.markStyle,
    required this.thumbStyle,
    this.crossAxisExtent = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  /// Returns a copy of this [FSliderStyle] but with the given fields replaced with the new values.
  @useResult
  FSliderStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    double? mainAxisPadding,
    double? crossAxisExtent,
    BorderRadius? borderRadius,
    FSliderMarkStyle? markStyle,
    FSliderThumbStyle? thumbStyle,
  }) =>
      FSliderStyle(
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
        borderRadius: borderRadius ?? this.borderRadius,
        markStyle: markStyle ?? this.markStyle,
        thumbStyle: thumbStyle ?? this.thumbStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('activeColor', activeColor))
      ..add(ColorProperty('inactiveColor', inactiveColor))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('markStyle', markStyle))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FSliderStyle &&
              runtimeType == other.runtimeType &&
              activeColor == other.activeColor &&
              inactiveColor == other.inactiveColor &&
              crossAxisExtent == other.crossAxisExtent &&
              borderRadius == other.borderRadius &&
              markStyle == other.markStyle &&
              thumbStyle == other.thumbStyle;

  @override
  int get hashCode =>
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      crossAxisExtent.hashCode ^
      borderRadius.hashCode ^
      markStyle.hashCode ^
      thumbStyle.hashCode;
}

@internal
class InheritedData extends InheritedWidget {
  final FSliderController controller;
  final FSliderStyle style;
  final Layout layout;
  final bool enabled;

  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context');
    return result!;
  }

  const InheritedData({
    required this.controller,
    required this.style,
    required this.layout,
    required this.enabled,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedData old) =>
      controller != old.controller ||
          style != old.style ||
          layout != old.layout ||
          enabled != old.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'));
  }
}
