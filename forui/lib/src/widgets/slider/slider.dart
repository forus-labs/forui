import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/layout.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/slider/inherited_data.dart';

/// An input where the user selects a value from within a given range.
///
/// See:
/// * https://forui.dev/docs/slider for working examples.
/// * [FContinuousSliderController.new] for selecting a single continuous value.
/// * [FContinuousSliderController.range] for selecting continuous range.
/// * [FDiscreteSliderController.new] for selecting a discrete value.
/// * [FDiscreteSliderController.range] for selecting a discrete range.
/// * [FSliderStyles] for customizing a slider's appearance.
class FSlider extends StatefulWidget {
  static Widget _tooltipBuilder(FTooltipStyle _, double value) => Text('${(value * 100).toStringAsFixed(0)}%');

  static String Function(FSliderSelection) _formatter(FSliderController controller) => switch (controller.extendable) {
        (min: true, max: false) => (selection) => '${(selection.offset.min * 100).toStringAsFixed(0)}%',
        (min: false, max: true) => (selection) => '${(selection.offset.max * 100).toStringAsFixed(0)}%',
        (min: true, max: true) || (min: false, max: false) => (selection) =>
            '${(selection.offset.min * 100).toStringAsFixed(0)}% - ${(selection.offset.max * 100).toStringAsFixed(0)}%',
      };

  static String _semanticValueFormatter(double value) => '${(value * 100).toStringAsFixed(0)}%';

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

  /// A builder that creates the tooltip. Defaults to printing the current percentage.
  final Widget Function(FTooltipStyle, double) tooltipBuilder;

  /// A callback that formats the semantic label for the slider. Defaults to announcing the percentages the active track
  /// occupies.
  final String Function(FSliderSelection) semanticFormatterCallback;

  /// A callback that formats the semantic label for the slider's thumb. Defaults to announcing the percentage.
  ///
  /// In practice, this is mostly useful for range sliders.
  // ignore: avoid_positional_boolean_parameters
  final String Function(double) semanticValueFormatterCallback;

  /// Creates a [FSlider].
  FSlider({
    required this.controller,
    this.style,
    this.layout = Layout.ltr,
    this.marks = const [],
    this.enabled = true,
    this.tooltipBuilder = _tooltipBuilder,
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
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback));
  }
}

class _FSliderState extends State<FSlider> {
  @override
  Widget build(BuildContext context) {
    final styles = context.theme.sliderStyles;
    final style = widget.style ??
        switch ((widget.enabled, widget.layout.vertical)) {
          (true, false) => styles.enabledHorizontalStyle,
          (true, true) => styles.enabledVerticalStyle,
          (false, false) => styles.disabledHorizontalStyle,
          (false, true) => styles.disabledVerticalStyle,
        };

    return InheritedData(
      style: style,
      layout: widget.layout,
      marks: widget.marks,
      enabled: widget.enabled,
      tooltipBuilder: widget.tooltipBuilder,
      semanticFormatterCallback: widget.semanticFormatterCallback,
      semanticValueFormatterCallback: widget.semanticValueFormatterCallback,
      child: LayoutBuilder(
        builder: (context, constraints) => SliderLayout(
          controller: widget.controller,
          style: style,
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
  /// The enabled slider's horizontal style.
  final FSliderStyle enabledHorizontalStyle;

  /// The enabled slider's vertical style.
  final FSliderStyle enabledVerticalStyle;

  /// The disabled slider's horizontal style.
  final FSliderStyle disabledHorizontalStyle;

  /// The disabled slider's vertical style.
  final FSliderStyle disabledVerticalStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({
    required this.enabledHorizontalStyle,
    required this.enabledVerticalStyle,
    required this.disabledHorizontalStyle,
    required this.disabledVerticalStyle,
  });

  /// Creates a [FSliderStyles] that inherits its properties from the given [FColorScheme].
  factory FSliderStyles.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) {
    final enabledHorizontalStyle = FSliderStyle(
      activeColor: colorScheme.primary,
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.primary),
        labelAnchor: Alignment.topCenter,
        labelOffset: 7.5,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.primaryForeground,
        borderColor: colorScheme.primary,
      ),
    );

    final disabledHorizontalStyle = FSliderStyle(
      activeColor: colorScheme.primary.withOpacity(0.7),
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.primary.withOpacity(0.7)),
        labelAnchor: Alignment.topCenter,
        labelOffset: 7.5,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.primaryForeground,
        borderColor: colorScheme.primary.withOpacity(0.7),
      ),
    );

    return FSliderStyles(
      enabledHorizontalStyle: enabledHorizontalStyle,
      enabledVerticalStyle: enabledHorizontalStyle.copyWith(
        markStyle: FSliderMarkStyle(
          tickColor: colorScheme.mutedForeground,
          labelTextStyle: typography.xs.copyWith(color: colorScheme.primary),
          labelAnchor: Alignment.centerRight,
          labelOffset: -7.5,
        ),
      ),
      disabledHorizontalStyle: disabledHorizontalStyle,
      disabledVerticalStyle: disabledHorizontalStyle.copyWith(
        markStyle: FSliderMarkStyle(
          tickColor: colorScheme.mutedForeground,
          labelTextStyle: typography.xs.copyWith(color: colorScheme.primary.withOpacity(0.7)),
          labelAnchor: Alignment.centerRight,
          labelOffset: -7.5,
        ),
      ),
    );
  }

  /// Returns a copy of this [FSliderStyles] but with the given fields replaced with the new values.
  @useResult
  FSliderStyles copyWith({
    FSliderStyle? enabledHorizontalStyle,
    FSliderStyle? enabledVerticalStyle,
    FSliderStyle? disabledHorizontalStyle,
    FSliderStyle? disabledVerticalStyle,
  }) =>
      FSliderStyles(
        enabledHorizontalStyle: enabledHorizontalStyle ?? this.enabledHorizontalStyle,
        enabledVerticalStyle: enabledVerticalStyle ?? this.enabledVerticalStyle,
        disabledHorizontalStyle: disabledHorizontalStyle ?? this.disabledHorizontalStyle,
        disabledVerticalStyle: disabledVerticalStyle ?? this.disabledVerticalStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledHorizontalStyle', enabledHorizontalStyle))
      ..add(DiagnosticsProperty('enabledVerticalStyle', enabledVerticalStyle))
      ..add(DiagnosticsProperty('disabledHorizontalStyle', disabledHorizontalStyle))
      ..add(DiagnosticsProperty('disabledVerticalStyle', disabledVerticalStyle));
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

  /// The slider marks' style.
  final FSliderMarkStyle markStyle;

  /// The slider thumb's style.
  final FSliderThumbStyle thumbStyle;

  /// The tooltip's style.
  final FTooltipStyle tooltipStyle;

  //// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned to. Defaults to [Alignment.bottomCenter].
  final Alignment tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned to. Defaults to [Alignment.topCenter].
  final Alignment tooltipThumbAnchor;

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.markStyle,
    required this.thumbStyle,
    required this.tooltipStyle,
    this.tooltipTipAnchor = Alignment.bottomCenter,
    this.tooltipThumbAnchor = Alignment.topCenter,
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
    FTooltipStyle? tooltipStyle,
    Alignment? tooltipTipAnchor,
    Alignment? tooltipThumbAnchor,
  }) =>
      FSliderStyle(
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
        borderRadius: borderRadius ?? this.borderRadius,
        markStyle: markStyle ?? this.markStyle,
        thumbStyle: thumbStyle ?? this.thumbStyle,
        tooltipStyle: tooltipStyle ?? this.tooltipStyle,
        tooltipTipAnchor: tooltipTipAnchor ?? this.tooltipTipAnchor,
        tooltipThumbAnchor: tooltipThumbAnchor ?? this.tooltipThumbAnchor,
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
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle))
      ..add(DiagnosticsProperty('tooltipTipAnchor', tooltipTipAnchor))
      ..add(DiagnosticsProperty('tooltipThumbAnchor', tooltipThumbAnchor));
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
          thumbStyle == other.thumbStyle &&
          tooltipStyle == other.tooltipStyle &&
          tooltipTipAnchor == other.tooltipTipAnchor &&
          tooltipThumbAnchor == other.tooltipThumbAnchor;

  @override
  int get hashCode =>
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      crossAxisExtent.hashCode ^
      borderRadius.hashCode ^
      markStyle.hashCode ^
      thumbStyle.hashCode ^
      tooltipStyle.hashCode ^
      tooltipTipAnchor.hashCode ^
      tooltipThumbAnchor.hashCode;
}
