import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/tappable.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/layout.dart';

/// An input where the user selects a value from within a given range.
///
/// A slider is a form field and therefore can be used within a [Form] widget.
///
/// See:
/// * https://forui.dev/docs/slider for working examples.
/// * [FContinuousSliderController.new] for selecting a single continuous value.
/// * [FContinuousSliderController.range] for selecting continuous range.
/// * [FDiscreteSliderController.new] for selecting a discrete value.
/// * [FDiscreteSliderController.range] for selecting a discrete range.
/// * [FSliderStyles] for customizing a slider's appearance.
class FSlider extends FormField<FSliderSelection> {
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

  /// The extent of the track's hit region in the cross-axis direction.
  ///
  /// Defaults to
  /// * either the tracker the thumb's cross extent, whichever is larger, on primarily touch devices.
  /// * 0 on non-primarily touch devices.
  final double? trackHitRegionCrossExtent;

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
    this.trackHitRegionCrossExtent,
    this.tooltipBuilder = _tooltipBuilder,
    this.semanticValueFormatterCallback = _semanticValueFormatter,
    String Function(FSliderSelection)? semanticFormatterCallback,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  })  : semanticFormatterCallback = semanticFormatterCallback ?? _formatter(controller),
        super(
          builder: (field) {
            final state = field as _State;
            final styles = state.context.theme.sliderStyles;
            final sliderStyle = style ??
                switch ((state.hasError, enabled, layout.vertical)) {
                  (true, _, false) => styles.errorHorizontalStyle,
                  (true, _, true) => styles.errorVerticalStyle,
                  (false, true, false) => styles.enabledHorizontalStyle,
                  (false, true, true) => styles.enabledVerticalStyle,
                  (false, false, false) => styles.disabledHorizontalStyle,
                  (false, false, true) => styles.disabledVerticalStyle,
                };

            // TODO wrap in FLabel.
            return InheritedData(
              style: sliderStyle,
              layout: layout,
              marks: marks,
              trackHitRegionCrossExtent: trackHitRegionCrossExtent,
              enabled: enabled,
              tooltipBuilder: tooltipBuilder,
              semanticFormatterCallback: semanticFormatterCallback ?? _formatter(controller),
              semanticValueFormatterCallback: semanticValueFormatterCallback,
              child: LayoutBuilder(
                builder: (context, constraints) => SliderLayout(
                  controller: controller,
                  style: sliderStyle,
                  layout: layout,
                  marks: marks,
                  constraints: constraints,
                ),
              ),
            );
          },
        );

  @override
  FormFieldState<FSliderSelection> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(DoubleProperty('trackHitRegionCrossExtent', trackHitRegionCrossExtent))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback));
  }
}

class _State extends FormFieldState<FSliderSelection> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FSlider old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    widget.controller.addListener(_handleControllerChanged);
    old.controller.removeListener(_handleControllerChanged);
  }

  @override
  void didChange(FSliderSelection? value) {
    super.didChange(value);
    // This is not 100% accurate since a controller's selection can never be null. However, users will have to go out
    // of their way to obtain a FormFieldState<FSliderSelection> via a GlobalKey AND call didChange(null).
    assert(value != null, "A slider's selection cannot be null.");
    if (widget.controller.selection != value) {
      widget.controller.selection = value;
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.reset();
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (widget.controller.selection != value) {
      didChange(widget.controller.selection);
    }
  }

  @override
  FSlider get widget => super.widget as FSlider;
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

  /// The error slider's horizontal style.
  final FSliderStyle errorHorizontalStyle;

  /// The error slider's vertical style.
  final FSliderStyle errorVerticalStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({
    required this.enabledHorizontalStyle,
    required this.enabledVerticalStyle,
    required this.disabledHorizontalStyle,
    required this.disabledVerticalStyle,
    required this.errorHorizontalStyle,
    required this.errorVerticalStyle,
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
        labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
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
        labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground.withOpacity(0.7)),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.primaryForeground,
        borderColor: colorScheme.primary.withOpacity(0.7),
      ),
    );

    final errorHorizontalStyle = FSliderStyle(
      activeColor: colorScheme.error,
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.error),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.errorForeground,
        borderColor: colorScheme.error,
      ),
    );

    return FSliderStyles(
      enabledHorizontalStyle: enabledHorizontalStyle,
      enabledVerticalStyle: enabledHorizontalStyle.copyWith(
        markStyle: FSliderMarkStyle(
          tickColor: colorScheme.mutedForeground,
          labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
          labelAnchor: Alignment.centerRight,
          labelOffset: -10,
        ),
      ),
      disabledHorizontalStyle: disabledHorizontalStyle,
      disabledVerticalStyle: disabledHorizontalStyle.copyWith(
        markStyle: FSliderMarkStyle(
          tickColor: colorScheme.mutedForeground,
          labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground.withOpacity(0.7)),
          labelAnchor: Alignment.centerRight,
          labelOffset: -10,
        ),
      ),
      errorHorizontalStyle: errorHorizontalStyle,
      errorVerticalStyle: errorHorizontalStyle.copyWith(
        markStyle: FSliderMarkStyle(
          tickColor: colorScheme.mutedForeground,
          labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
          labelAnchor: Alignment.centerRight,
          labelOffset: -10,
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
    FSliderStyle? errorHorizontalStyle,
    FSliderStyle? errorVerticalStyle,
  }) =>
      FSliderStyles(
        enabledHorizontalStyle: enabledHorizontalStyle ?? this.enabledHorizontalStyle,
        enabledVerticalStyle: enabledVerticalStyle ?? this.enabledVerticalStyle,
        disabledHorizontalStyle: disabledHorizontalStyle ?? this.disabledHorizontalStyle,
        disabledVerticalStyle: disabledVerticalStyle ?? this.disabledVerticalStyle,
        errorHorizontalStyle: errorHorizontalStyle ?? this.errorHorizontalStyle,
        errorVerticalStyle: errorVerticalStyle ?? this.errorVerticalStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledHorizontalStyle', enabledHorizontalStyle))
      ..add(DiagnosticsProperty('enabledVerticalStyle', enabledVerticalStyle))
      ..add(DiagnosticsProperty('disabledHorizontalStyle', disabledHorizontalStyle))
      ..add(DiagnosticsProperty('disabledVerticalStyle', disabledVerticalStyle))
      ..add(DiagnosticsProperty('errorHorizontalStyle', errorHorizontalStyle))
      ..add(DiagnosticsProperty('errorVerticalStyle', errorVerticalStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderStyles &&
          runtimeType == other.runtimeType &&
          enabledHorizontalStyle == other.enabledHorizontalStyle &&
          enabledVerticalStyle == other.enabledVerticalStyle &&
          disabledHorizontalStyle == other.disabledHorizontalStyle &&
          disabledVerticalStyle == other.disabledVerticalStyle &&
          errorHorizontalStyle == other.errorHorizontalStyle &&
          errorVerticalStyle == other.errorVerticalStyle;

  @override
  int get hashCode =>
      enabledHorizontalStyle.hashCode ^
      enabledVerticalStyle.hashCode ^
      disabledHorizontalStyle.hashCode ^
      disabledVerticalStyle.hashCode ^
      errorHorizontalStyle.hashCode ^
      errorVerticalStyle.hashCode;
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

  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  final Alignment tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.topCenter] on primarily touch devices and [Alignment.centerRight] on non-primarily touch
  /// devices.
  final Alignment tooltipThumbAnchor;

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.markStyle,
    required this.thumbStyle,
    required this.tooltipStyle,
    Alignment? tooltipTipAnchor,
    Alignment? tooltipThumbAnchor,
    this.crossAxisExtent = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  }):
    tooltipTipAnchor = tooltipTipAnchor ?? (Touch.primary ? Alignment.bottomCenter : Alignment.centerLeft),
    tooltipThumbAnchor = tooltipThumbAnchor ?? (Touch.primary ? Alignment.topCenter : Alignment.centerRight);

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
