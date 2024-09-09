import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/layout_builder.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:forui/src/widgets/slider/track.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/slider/inherited_data.dart';

class FSlider extends StatefulWidget {
  static String Function(FSliderSelection) _formatter(FSliderController controller) => switch (controller.extendable) {
        (min: true, max: false) => (selection) => '${selection.offset.min}%',
        (min: false, max: true) => (selection) => '${selection.offset.max}%',
        (min: true, max: true) || (min: false, max: false) => (selection) =>
            '${selection.offset.min}% - ${selection.offset.max}%',
      };

  static String _semanticValueFormatter(FSliderSelection selection, bool min) =>
      '${min ? selection.offset.min : selection.offset.max}%';

  /// The controller.
  final FSliderController controller;

  /// The style.
  final FSliderStyle? style;

  /// The layout. Defaults to [Layout.ltr].
  final Layout layout;

  /// The marks.
  final List<FSliderMark> marks;

  /// True if this slider is enabled. Defaults to true.
  final bool enabled;

  /// A callback that formats the semantic label for the slider. Defaults to announcing the percentages the active track
  /// occupies.
  final String Function(FSliderSelection) semanticFormatterCallback;

  /// A callback that formats the semantic label for the slider's thumb. Defaults to announcing the percentage.
  ///
  /// In practice, this is mostly useful for range sliders.
  // ignore: avoid_positional_boolean_parameters
  final String Function(FSliderSelection, bool) semanticValueFormatterCallback;

  /// Creates a [FSlider].
  FSlider({
    required this.controller,
    this.style,
    this.layout = Layout.ltr,
    this.marks = const [],
    this.enabled = true,
    this.semanticValueFormatterCallback = _semanticValueFormatter,
    String Function(FSliderSelection)? semanticFormatterCallback,
    super.key,
  }) : semanticFormatterCallback = semanticFormatterCallback ?? _formatter(controller);

  @override
  State<FSlider> createState() => _FSliderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback));
  }
}

class _FSliderState extends State<FSlider> {
  @override
  Widget build(BuildContext context) {
    final styles = context.theme.sliderStyles;
    final style = widget.style ?? (widget.enabled ? styles.enabledStyle : styles.disabledStyle);

    return InheritedData(
      controller: widget.controller,
      style: style,
      layout: widget.layout,
      marks: widget.marks,
      enabled: widget.enabled,
      semanticFormatterCallback: widget.semanticFormatterCallback,
      semanticValueFormatterCallback: widget.semanticValueFormatterCallback,
      child: LayoutBuilder(
        builder: (context, constraints) => SliderLayoutBuilder(
          controller: widget.controller,
          layout: widget.layout,
          marks: widget.marks,
          constraints: constraints,
        ),
      ),
    );
  }
}

/// A slider's styles.
final class FSliderStyles with Diagnosticable {
  /// The enabled slider's style.
  final FSliderStyle enabledStyle;

  /// The disabled slider's style.
  final FSliderStyle disabledStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({
    required this.enabledStyle,
    required this.disabledStyle,
  });

  /// Creates a [FSliderStyles] that inherits its properties from the given [FColorScheme].
  FSliderStyles.inherit({required FColorScheme colorScheme, required FTypography typography})
      : enabledStyle = FSliderStyle(
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.secondary,
          markStyles: (
            horizontal: FSliderMarkStyle(
              tickColor: colorScheme.mutedForeground,
              labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground),
              labelAnchor: Alignment.topCenter,
              labelOffset: 10,
            ),
            vertical: FSliderMarkStyle(
              tickColor: colorScheme.mutedForeground,
              labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground),
              labelAnchor: Alignment.centerRight,
              labelOffset: -10,
            ),
          ),
          thumbStyle: FSliderThumbStyle(
            color: colorScheme.primaryForeground,
            borderColor: colorScheme.primary,
          ),
        ),
        disabledStyle = FSliderStyle(
          activeColor: colorScheme.primary.withOpacity(0.7),
          inactiveColor: colorScheme.secondary,
          markStyles: (
            horizontal: FSliderMarkStyle(
              tickColor: colorScheme.mutedForeground,
              labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground.withOpacity(0.7)),
              labelAnchor: Alignment.topCenter,
              labelOffset: 10,
            ),
            vertical: FSliderMarkStyle(
              tickColor: colorScheme.mutedForeground,
              labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground.withOpacity(0.7)),
              labelAnchor: Alignment.centerRight,
              labelOffset: -10,
            ),
          ),
          thumbStyle: FSliderThumbStyle(
            color: colorScheme.primaryForeground.withOpacity(0.7),
            borderColor: colorScheme.primary.withOpacity(0.7),
          ),
        );

  /// Returns a copy of this [FSliderStyles] but with the given fields replaced with the new values.
  @useResult
  FSliderStyles copyWith({
    FSliderStyle? enabledStyle,
    FSliderStyle? disabledStyle,
  }) =>
      FSliderStyles(
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }
}

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

  /// The slider marks' styles.
  final ({FSliderMarkStyle horizontal, FSliderMarkStyle vertical}) markStyles;

  /// The slider thumb's style.
  final FSliderThumbStyle thumbStyle;

  // TODO: tooltip style?

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.markStyles,
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
    ({FSliderMarkStyle horizontal, FSliderMarkStyle vertical})? markStyles,
    FSliderThumbStyle? thumbStyle,
  }) =>
      FSliderStyle(
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
        borderRadius: borderRadius ?? this.borderRadius,
        markStyles: markStyles ?? this.markStyles,
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
      ..add(DiagnosticsProperty('markStyles.horizontal', markStyles.horizontal))
      ..add(DiagnosticsProperty('markStyles.vertical', markStyles.vertical))
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
          markStyles == other.markStyles &&
          thumbStyle == other.thumbStyle;

  @override
  int get hashCode =>
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      crossAxisExtent.hashCode ^
      borderRadius.hashCode ^
      markStyles.hashCode ^
      thumbStyle.hashCode;
}
