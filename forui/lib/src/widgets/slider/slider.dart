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
class FSlider extends StatelessWidget with FFormFieldProperties<FSliderSelection> {
  static Widget _tooltipBuilder(FTooltipController _, double value) => Text('${(value * 100).toStringAsFixed(0)}%');

  static String _semanticValueFormatter(double value) => '${(value * 100).toStringAsFixed(0)}%';

  /// The controller. Defaults to [FContinuousSliderController.new].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * Both [controller] and [initialSelection] are provided.
  final FSliderController? controller;

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

  /// The initial selection.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * Both [controller] and [initialSelection] are provided.
  final FSliderSelection? initialSelection;

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
  final Widget Function(FTooltipController controller, double value) tooltipBuilder;

  /// A callback that formats the semantic label for the slider. Defaults to announcing the percentages the active track
  /// occupies.
  final String Function(FSliderSelection)? semanticFormatterCallback;

  /// A callback that formats the semantic label for the slider's thumb. Defaults to announcing the percentage.
  ///
  /// In practice, this is mostly useful for range sliders.
  final String Function(double) semanticValueFormatterCallback;

  @override
  final Widget? label;

  @override
  final Widget? description;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  @override
  final bool enabled;

  /// Handler for when the slider value changes.
  final ValueChanged<FSliderSelection>? onChange;

  @override
  final FormFieldSetter<FSliderSelection>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final FormFieldValidator<FSliderSelection>? validator;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  /// Creates a [FSlider].
  FSlider({
    required this.controller,
    this.style,
    this.layout,
    this.label,
    this.description,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.marks = const [],
    this.initialSelection,
    this.trackMainAxisExtent,
    this.trackHitRegionCrossExtent,
    this.tooltipBuilder = _tooltipBuilder,
    this.semanticValueFormatterCallback = _semanticValueFormatter,
    this.semanticFormatterCallback,
    this.onChange,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    super.key,
  }) : assert(
         controller == null || initialSelection == null,
         'Cannot provide both controller and initialSelection at the same time',
       ) {
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
      _ when Directionality.maybeOf(context) == TextDirection.rtl => FLayout.rtl,
      _ => FLayout.ltr,
    };

    final styles = context.theme.sliderStyles;
    final inheritedStyle = (layout.vertical ? styles.verticalStyle : styles.horizontalStyle);
    final sliderStyle = style?.call(inheritedStyle) ?? inheritedStyle;

    return LayoutBuilder(
      builder: (_, constraints) => _Slider(
        controller: controller,
        style: sliderStyle,
        layout: layout,
        label: label,
        description: description,
        errorBuilder: errorBuilder,
        marks: marks,
        textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
        constraints: constraints,
        mainAxisExtent: trackMainAxisExtent,
        trackHitRegionCrossExtent: trackHitRegionCrossExtent,
        tooltipBuilder: tooltipBuilder,
        semanticFormatterCallback: semanticFormatterCallback,
        semanticValueFormatterCallback: semanticValueFormatterCallback,
        initialSelection: initialSelection,
        onSaved: onSaved,
        onReset: onReset,
        validator: validator,
        autovalidateMode: autovalidateMode,
        forceErrorText: forceErrorText,
        enabled: enabled,
        onChange: onChange,
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
      ..add(DiagnosticsProperty('initialSelection', initialSelection))
      ..add(DoubleProperty('trackMainAxisExtent', trackMainAxisExtent))
      ..add(DoubleProperty('trackHitRegionCrossExtent', trackHitRegionCrossExtent))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('forceErrorText', forceErrorText));
  }
}

class _Slider extends StatefulWidget {
  final FSliderController? controller;
  final FSliderStyle style;
  final FLayout layout;
  final Widget? label;
  final Widget? description;
  final Widget Function(BuildContext context, String message) errorBuilder;
  final List<FSliderMark> marks;
  final FSliderSelection? initialSelection;
  final TextDirection textDirection;
  final BoxConstraints constraints;
  final double? mainAxisExtent;
  final double? trackHitRegionCrossExtent;
  final Widget Function(FTooltipController controller, double value) tooltipBuilder;
  final String Function(FSliderSelection)? semanticFormatterCallback;
  final String Function(double) semanticValueFormatterCallback;
  final ValueChanged<FSliderSelection>? onChange;
  final FormFieldSetter<FSliderSelection>? onSaved;
  final VoidCallback? onReset;
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
    required this.initialSelection,
    required this.textDirection,
    required this.constraints,
    required this.mainAxisExtent,
    required this.trackHitRegionCrossExtent,
    required this.tooltipBuilder,
    required this.semanticFormatterCallback,
    required this.semanticValueFormatterCallback,
    required this.onChange,
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
      ..add(DiagnosticsProperty('controller', controller))
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
      ..add(DiagnosticsProperty('initialSelection', initialSelection))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticValueFormatterCallback', semanticValueFormatterCallback))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }
}

class _SliderState extends State<_Slider> {
  late FSliderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _createController();
    _controller
      ..attach(widget._mainAxisExtent, widget.marks)
      ..addListener(_onChange);
  }

  @override
  void didUpdateWidget(covariant _Slider old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        old.controller?.removeListener(_onChange);
      }

      _controller = _createController();
      _controller
        ..attach(widget._mainAxisExtent, widget.marks)
        ..addListener(_onChange);
    } else if (widget.layout != old.layout ||
        widget._mainAxisExtent != old._mainAxisExtent ||
        !widget.marks.equals(old.marks)) {
      _controller.attach(widget._mainAxisExtent, widget.marks);
    }
  }

  FSliderController _createController() =>
      widget.controller ?? FContinuousSliderController(selection: widget.initialSelection ?? FSliderSelection(max: 0));

  void _onChange() => widget.onChange?.call(_controller.selection);

  @override
  Widget build(BuildContext _) => InheritedData(
    style: widget.style,
    layout: widget.layout,
    marks: widget.marks,
    trackMainAxisExtent: widget.mainAxisExtent,
    trackHitRegionCrossExtent: widget.trackHitRegionCrossExtent,
    enabled: widget.enabled,
    tooltipBuilder: widget.tooltipBuilder,
    semanticFormatterCallback: widget.semanticFormatterCallback ?? formatter,
    semanticValueFormatterCallback: widget.semanticValueFormatterCallback,
    child: ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => InheritedController(
        controller: _controller,
        child: SliderFormField(
          controller: _controller,
          constraints: widget.constraints,
          label: widget.label,
          description: widget.description,
          errorBuilder: widget.errorBuilder,
          onSaved: widget.onSaved,
          onReset: widget.onReset,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
          forceErrorText: widget.forceErrorText,
          enabled: widget.enabled,
        ),
      ),
    ),
  );

  String Function(FSliderSelection) get formatter => switch (_controller.extendable) {
    (min: true, max: false) => (selection) => '${(selection.offset.min * 100).toStringAsFixed(0)}%',
    (min: false, max: true) => (selection) => '${(selection.offset.max * 100).toStringAsFixed(0)}%',
    (min: true, max: true) || (min: false, max: false) =>
      (selection) =>
          '${(selection.offset.min * 100).toStringAsFixed(0)}% - ${(selection.offset.max * 100).toStringAsFixed(0)}%',
  };

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onChange);
    }
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<String Function(FSliderSelection p1)>.has('formatter', formatter));
  }
}
