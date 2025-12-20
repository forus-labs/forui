import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/form_field.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/slider_control.dart';
import 'package:forui/src/widgets/tooltip/tooltip_controller.dart';

/// An input where the user selects a value from within a given range.
///
/// A slider is a form field and therefore can be used within a [Form] widget.
///
/// See:
/// * https://forui.dev/docs/form/slider for working examples.
/// * [FSliderControl] for configuring a slider's behavior.
/// * [FSliderStyles] for customizing a slider's appearance.
class FSlider extends StatelessWidget with FFormFieldProperties<FSliderValue> {
  static Widget _tooltipBuilder(FTooltipController _, double value) => Text('${(value * 100).toStringAsFixed(0)}%');

  static String _semanticValueFormatter(double value) => '${(value * 100).toStringAsFixed(0)}%';

  /// The control for the slider.
  final FSliderControl control;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sliders
  /// ```
  final FSliderStyle Function(FSliderStyle style)? style;

  /// The layout. Defaults to the current [TextDirection].
  final FLayout? layout;

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

  /// The control for the slider's tooltips.
  final FSliderTooltipControls tooltipControls;

  /// A builder that creates the tooltip. Defaults to printing the current percentage.
  final Widget Function(FTooltipController controller, double value) tooltipBuilder;

  /// A callback that formats the semantic label for the slider. Defaults to announcing the percentages the active track
  /// occupies.
  final String Function(FSliderValue)? semanticFormatterCallback;

  /// A callback that formats the semantic label for the slider's thumb. Defaults to announcing the percentage.
  ///
  /// In practice, this is mostly useful for range sliders.
  final String Function(double) semanticValueFormatterCallback;

  /// Called when the user finishes interacting with the slider.
  ///
  /// It is not called when the slider's value is changed programmatically.
  final ValueChanged<FSliderValue>? onEnd;

  @override
  final Widget? label;

  @override
  final Widget? description;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  @override
  final bool enabled;

  @override
  final FormFieldSetter<FSliderValue>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final FormFieldValidator<FSliderValue>? validator;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  /// Creates a [FSlider].
  FSlider({
    this.control = const .managedContinuous(),
    this.style,
    this.layout,
    this.label,
    this.description,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.marks = const [],
    this.trackMainAxisExtent,
    this.trackHitRegionCrossExtent,
    this.tooltipControls = const .new(),
    this.tooltipBuilder = _tooltipBuilder,
    this.semanticValueFormatterCallback = _semanticValueFormatter,
    this.semanticFormatterCallback,
    this.onEnd,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = .disabled,
    super.key,
  }) {
    if (trackMainAxisExtent == null &&
        (label != null || description != null || forceErrorText != null) &&
        (layout?.vertical ?? false)) {
      throw StateError(
        'A vertical FSlider was given a label, description, or forceErrorText although it needs a trackMainAxisExtent. '
        'To fix this, consider supplying a trackMainAxisExtent or changing the layout to horizontal.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = switch (this.layout) {
      final layout? => layout,
      _ when Directionality.maybeOf(context) == .rtl => FLayout.rtl,
      _ => FLayout.ltr,
    };

    final styles = context.theme.sliderStyles;
    final inheritedStyle = (layout.vertical ? styles.verticalStyle : styles.horizontalStyle);
    final sliderStyle = style?.call(inheritedStyle) ?? inheritedStyle;

    return LayoutBuilder(
      builder: (_, constraints) => _Slider(
        control: control,
        style: sliderStyle,
        layout: layout,
        label: label,
        description: description,
        errorBuilder: errorBuilder,
        marks: marks,
        textDirection: Directionality.maybeOf(context) ?? .ltr,
        constraints: constraints,
        mainAxisExtent: trackMainAxisExtent,
        trackHitRegionCrossExtent: trackHitRegionCrossExtent,
        tooltipControls: tooltipControls,
        tooltipBuilder: tooltipBuilder,
        semanticFormatterCallback: semanticFormatterCallback,
        semanticValueFormatterCallback: semanticValueFormatterCallback,
        onEnd: onEnd,
        onSaved: onSaved,
        onReset: onReset,
        validator: validator,
        autovalidateMode: autovalidateMode,
        forceErrorText: forceErrorText,
        enabled: enabled,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(IterableProperty('marks', marks))
      ..add(DoubleProperty('trackMainAxisExtent', trackMainAxisExtent))
      ..add(DoubleProperty('trackHitRegionCrossExtent', trackHitRegionCrossExtent))
      ..add(DiagnosticsProperty('tooltipControls', tooltipControls))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback))
      ..add(ObjectFlagProperty.has('onEnd', onEnd))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('forceErrorText', forceErrorText));
  }
}

class _Slider extends StatefulWidget {
  final FSliderControl control;
  final FSliderStyle style;
  final FLayout layout;
  final Widget? label;
  final Widget? description;
  final Widget Function(BuildContext context, String message) errorBuilder;
  final List<FSliderMark> marks;
  final TextDirection textDirection;
  final BoxConstraints constraints;
  final double? mainAxisExtent;
  final double? trackHitRegionCrossExtent;
  final FSliderTooltipControls tooltipControls;
  final Widget Function(FTooltipController controller, double value) tooltipBuilder;
  final String Function(FSliderValue)? semanticFormatterCallback;
  final String Function(double) semanticValueFormatterCallback;
  final ValueChanged<FSliderValue>? onEnd;
  final FormFieldSetter<FSliderValue>? onSaved;
  final VoidCallback? onReset;
  final FormFieldValidator<FSliderValue>? validator;
  final AutovalidateMode? autovalidateMode;
  final String? forceErrorText;
  final bool enabled;

  const _Slider({
    required this.control,
    required this.style,
    required this.layout,
    required this.label,
    required this.description,
    required this.errorBuilder,
    required this.marks,
    required this.textDirection,
    required this.constraints,
    required this.mainAxisExtent,
    required this.trackHitRegionCrossExtent,
    required this.tooltipControls,
    required this.tooltipBuilder,
    required this.semanticFormatterCallback,
    required this.semanticValueFormatterCallback,
    required this.onEnd,
    required this.onSaved,
    required this.onReset,
    required this.validator,
    required this.autovalidateMode,
    required this.forceErrorText,
    required this.enabled,
  });

  @override
  State<_Slider> createState() => _SliderState();

  double get _mainAxisExtent {
    final insets = style.childPadding.resolve(textDirection);
    final extent = switch (mainAxisExtent) {
      final extent? => extent,
      _ when layout.vertical => constraints.maxHeight - insets.top - insets.bottom,
      _ => constraints.maxWidth - insets.left - insets.right,
    };

    if (extent.isInfinite) {
      throw FlutterError(switch (layout.vertical) {
        true =>
          'A vertical FSlider was given an infinite height although it needs a finite height. To fix this, '
              'consider supplying a mainAxisExtent or placing FSlider in a SizedBox.',
        false =>
          'A horizontal FSlider was given an infinite width although it needs a finite width. To fix this, '
              'consider supplying a mainAxisExtent or placing FSlider in a SizedBox.',
      });
    }

    return extent - style.thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(IterableProperty('marks', marks))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('forceErrorText', forceErrorText))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('trackHitRegionCrossExtent', trackHitRegionCrossExtent))
      ..add(DiagnosticsProperty('tooltipControls', tooltipControls))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback))
      ..add(ObjectFlagProperty.has('onEnd', onEnd));
  }
}

class _SliderState extends State<_Slider> with TickerProviderStateMixin {
  late FSliderController _controller;
  late FTooltipController _minTooltipController;
  late FTooltipController _maxTooltipController;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange);
    _controller.attach(widget._mainAxisExtent, widget.marks);
    _minTooltipController = widget.tooltipControls.min.create(_handleMinTooltipChange, this);
    _maxTooltipController = widget.tooltipControls.max.create(_handleMaxTooltipChange, this);
  }

  @override
  void didUpdateWidget(covariant _Slider old) {
    super.didUpdateWidget(old);
    final (controller, updated) = widget.control.update(old.control, _controller, _handleOnChange);
    if (updated ||
        widget.layout != old.layout ||
        widget._mainAxisExtent != old._mainAxisExtent ||
        !widget.marks.equals(old.marks)) {
      _controller = controller..attach(widget._mainAxisExtent, widget.marks);
    }

    _minTooltipController = widget.tooltipControls.min
        .update(old.tooltipControls.min, _minTooltipController, _handleMinTooltipChange, this)
        .$1;
    _maxTooltipController = widget.tooltipControls.max
        .update(old.tooltipControls.max, _maxTooltipController, _handleMaxTooltipChange, this)
        .$1;
  }

  @override
  void dispose() {
    widget.tooltipControls.max.dispose(_maxTooltipController, _handleMaxTooltipChange);
    widget.tooltipControls.min.dispose(_minTooltipController, _handleMinTooltipChange);
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FSliderManagedControl(:final onChange?)) {
      onChange.call(_controller.value);
    }
  }

  void _handleMinTooltipChange() {
    if (widget.tooltipControls.min case FTooltipManagedControl(:final onChange?)) {
      onChange.call(_minTooltipController.status.isForwardOrCompleted);
    }
  }

  void _handleMaxTooltipChange() {
    if (widget.tooltipControls.max case FTooltipManagedControl(:final onChange?)) {
      onChange.call(_maxTooltipController.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext _) => InheritedData(
    style: widget.style,
    layout: widget.layout,
    marks: widget.marks,
    trackMainAxisExtent: widget.mainAxisExtent,
    trackHitRegionCrossExtent: widget.trackHitRegionCrossExtent,
    enabled: widget.enabled,
    tooltipBuilder: widget.tooltipBuilder,
    semanticFormatterCallback: widget.semanticFormatterCallback ?? _formatter,
    semanticValueFormatterCallback: widget.semanticValueFormatterCallback,
    onEnd: widget.onEnd,
    child: ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => InheritedController(
        controller: _controller,
        minTooltipController: widget.tooltipControls.enabled ? _minTooltipController : null,
        maxTooltipController: widget.tooltipControls.enabled ? _maxTooltipController : null,
        child: SliderFormField(
          controller: _controller,
          constraints: widget.constraints,
          label: widget.label,
          description: widget.description,
          errorBuilder: widget.errorBuilder,
          onSaved: widget.onSaved,
          onReset: widget.onReset,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode ?? .disabled,
          forceErrorText: widget.forceErrorText,
          enabled: widget.enabled,
        ),
      ),
    ),
  );

  String Function(FSliderValue) get _formatter => switch (_controller.active) {
    (min: true, max: false) => (value) => '${(value.min * 100).toStringAsFixed(0)}%',
    (min: false, max: true) => (value) => '${(value.max * 100).toStringAsFixed(0)}%',
    (min: true, max: true) || (min: false, max: false) =>
      (value) => '${(value.min * 100).toStringAsFixed(0)}% - ${(value.max * 100).toStringAsFixed(0)}%',
  };
}
