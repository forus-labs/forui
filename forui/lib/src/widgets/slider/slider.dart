import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/form_field.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';

/// An input where the user selects a value from within a given range.
///
/// A slider is a form field and therefore can be used within a [Form] widget.
///
/// See:
/// * https://forui.dev/docs/form/slider for working examples.
/// * [FContinuousSliderController.new] for selecting a single continuous value.
/// * [FContinuousSliderController.range] for selecting continuous range.
/// * [FDiscreteSliderController.new] for selecting a discrete value.
/// * [FDiscreteSliderController.range] for selecting a discrete range.
/// * [FSliderStyles] for customizing a slider's appearance.
class FSlider extends StatelessWidget {
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
  ///
  /// Throws [StateError] if [trackMainAxisExtent], either [label], [description], or [forceErrorText] is given,
  /// and [layout] is vertical.
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

  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final FormFieldSetter<FSliderSelection>? onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property. It transforms the text using
  /// [errorBuilder].
  ///
  /// Alternating between error and normal state can cause the height of the [FTextField] to change if no other
  /// subtext decoration is set on the field. To create a field whose height is fixed regardless of whether or not an
  /// error is displayed, wrap the [FTextField] in a fixed height parent like [SizedBox].
  final FormFieldValidator<FSliderSelection>? validator;

  /// Used to enable/disable this form field auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  ///
  /// If [AutovalidateMode.onUserInteraction], this FormField will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode? autovalidateMode;

  /// An optional property that forces the [FormFieldState] into an error state
  /// by directly setting the [FormFieldState.errorText] property without
  /// running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText]
  /// will be set to the provided value, causing the form field to be considered
  /// invalid and to display the error message specified.
  ///
  /// When [validator] is provided, [forceErrorText] will override any error that it
  /// returns. [validator] will not be called unless [forceErrorText] is null.
  final String? forceErrorText;

  /// True if the slider is enabled.
  final bool enabled;

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
    this.onSaved,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode,
    super.key,
  }) : semanticFormatterCallback = semanticFormatterCallback ?? _formatter(controller) {
    if (trackMainAxisExtent == null &&
        (label != null || description != null || forceErrorText != null) &&
        layout.vertical) {
      throw StateError(
        'A vertical FSlider was given a label, description, or forceErrorText although it needs a trackMainAxisExtent. '
        'To fix this, consider supplying a trackMainAxisExtent or changing the layout to horizontal.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final styles = context.theme.sliderStyles;
    final sliderStyle = style ?? (layout.vertical ? styles.verticalStyle : styles.horizontalStyle);
    return InheritedData(
      style: sliderStyle,
      layout: layout,
      marks: marks,
      trackMainAxisExtent: trackMainAxisExtent,
      trackHitRegionCrossExtent: trackHitRegionCrossExtent,
      enabled: enabled,
      tooltipBuilder: tooltipBuilder,
      semanticFormatterCallback: semanticFormatterCallback,
      semanticValueFormatterCallback: semanticValueFormatterCallback,
      child: LayoutBuilder(
        builder: (context, constraints) => _Slider(
          controller: controller,
          style: sliderStyle,
          layout: layout,
          label: label,
          description: description,
          errorBuilder: errorBuilder,
          marks: marks,
          constraints: constraints,
          mainAxisExtent: trackMainAxisExtent,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          forceErrorText: forceErrorText,
          enabled: enabled,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(IterableProperty('marks', marks))
      ..add(DoubleProperty('trackMainAxisExtent', trackMainAxisExtent))
      ..add(DoubleProperty('trackHitRegionCrossExtent', trackHitRegionCrossExtent))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('forceErrorText', forceErrorText));
  }
}

class _Slider extends StatefulWidget {
  final FSliderController controller;
  final FSliderStyle style;
  final Layout layout;
  final Widget? label;
  final Widget? description;
  final Widget Function(BuildContext, String) errorBuilder;
  final List<FSliderMark> marks;
  final BoxConstraints constraints;
  final double? mainAxisExtent;
  final FormFieldSetter<FSliderSelection>? onSaved;
  final FormFieldValidator<FSliderSelection>? validator;
  final AutovalidateMode? autovalidateMode;
  final String? forceErrorText;
  final bool enabled;

  const _Slider({
    required this.controller,
    required this.style,
    required this.layout,
    required this.label,
    required this.description,
    required this.errorBuilder,
    required this.marks,
    required this.constraints,
    required this.mainAxisExtent,
    required this.onSaved,
    required this.validator,
    required this.autovalidateMode,
    required this.forceErrorText,
    required this.enabled,
  });

  @override
  State<_Slider> createState() => _SliderState();

  double get _mainAxisExtent {
    final insets = style.labelLayoutStyle.childPadding;
    final extent = switch (mainAxisExtent) {
      final extent? => extent,
      _ when layout.vertical => constraints.maxHeight - insets.top - insets.bottom,
      _ => constraints.maxWidth - insets.left - insets.right,
    };

    if (extent.isInfinite) {
      throw FlutterError(
        switch (layout.vertical) {
          true => 'A vertical FSlider was given an infinite height although it needs a finite height. To fix this, '
              'consider supplying a mainAxisExtent or placing FSlider in a SizedBox.',
          false => 'A horizontal FSlider was given an infinite width although it needs a finite width. To fix this, '
              'consider supplying a mainAxisExtent or placing FSlider in a SizedBox.',
        },
      );
    }

    return extent - style.thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(IterableProperty('marks', marks))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('forceErrorText', forceErrorText))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

class _SliderState extends State<_Slider> {
  @override
  void initState() {
    super.initState();
    widget.controller.attach(widget._mainAxisExtent, widget.marks);
  }

  @override
  void didUpdateWidget(covariant _Slider old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller ||
        widget.layout != old.layout ||
        widget._mainAxisExtent != old._mainAxisExtent ||
        !widget.marks.equals(old.marks)) {
      widget.controller.attach(widget._mainAxisExtent, widget.marks);
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) => InheritedController(
          controller: widget.controller,
          child: SliderFormField(
            controller: widget.controller,
            constraints: widget.constraints,
            label: widget.label,
            description: widget.description,
            errorBuilder: widget.errorBuilder,
            onSaved: widget.onSaved,
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            forceErrorText: widget.forceErrorText,
            enabled: widget.enabled,
          ),
        ),
      );
}
