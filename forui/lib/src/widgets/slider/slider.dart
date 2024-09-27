import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
  static Widget _errorBuilder(BuildContext context, String error) => Text(error);

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

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  final Widget Function(BuildContext, String) errorBuilder;

  /// The marks.
  final List<FSliderMark> marks;

  /// The extent of the track along the main axis. Defaults to occupying the maximum amount of space possible along the
  /// main axis.
  ///
  /// **Contract**:
  /// Throws [AssertionError] if [trackMainAxisExtent] is not positive.
  final double? trackMainAxisExtent;

  /// The extent of the track's hit region in the cross-axis direction.
  ///
  /// Defaults to:
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
    this.label,
    this.description,
    this.errorBuilder = _errorBuilder,
    this.marks = const [],
    this.trackMainAxisExtent,
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
            final sliderStyle = style ?? (layout.vertical ? styles.verticalStyle : styles.horizontalStyle);
            final (labelState, stateStyle) = switch ((state.hasError, enabled)) {
              (false, true) => (FLabelState.enabled, sliderStyle.enabledStyle),
              (false, false) => (FLabelState.disabled, sliderStyle.disabledStyle),
              (true, _) => (FLabelState.error, sliderStyle.errorStyle),
            };

            return InheritedData(
              style: sliderStyle,
              stateStyle: stateStyle,
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
                  layoutStyle: sliderStyle.labelLayoutStyle,
                  stateStyle: stateStyle,
                  state: labelState,
                  layout: layout,
                  label: label == null
                      ? const SizedBox()
                      : DefaultTextStyle(
                          style: stateStyle.labelTextStyle,
                          child: Padding(
                            padding: sliderStyle.labelLayoutStyle.labelPadding,
                            child: label,
                          ),
                        ),
                  description: description == null
                      ? const SizedBox()
                      : DefaultTextStyle.merge(
                          style: stateStyle.descriptionTextStyle,
                          child: Padding(
                            padding: sliderStyle.labelLayoutStyle.descriptionPadding,
                            child: description,
                          ),
                        ),
                  error: state.errorText == null
                      ? const SizedBox()
                      : DefaultTextStyle.merge(
                    style: (stateStyle as FSliderErrorStyle).errorTextStyle,
                        child: Padding(
                            padding: sliderStyle.labelLayoutStyle.errorPadding,
                            child: errorBuilder(context, state.errorText!),
                          ),
                      ),
                  marks: marks,
                  constraints: constraints,
                  mainAxisExtent: trackMainAxisExtent,
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
      ..add(DoubleProperty('trackMainAxisExtent', trackMainAxisExtent))
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
    // TODO: fix bug when resizing window.
    // This is not 100% accurate since a controller's selection can never be null. However, users will have to go out
    // of their way to obtain a FormFieldState<FSliderSelection> via a GlobalKey AND call didChange(null).
    assert(value != null, "A slider's selection cannot be null.");
    super.didChange(value);
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
