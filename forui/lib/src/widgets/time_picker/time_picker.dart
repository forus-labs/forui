import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_picker/picker.dart';
import 'package:forui/src/widgets/time_picker/time_picker_controller.dart';

part 'time_picker.design.dart';

/// A time picker that allows a time to be selected.
///
/// Recommended for touch devices.
///
/// The time picker supports arrow key navigation:
/// * Up/Down arrows: Increment/decrement selected value
/// * Left/Right arrows: Move between wheels
///
/// See:
/// * https://forui.dev/docs/form/time-picker for working examples.
/// * [FTimePickerController] for controlling a time picker.
/// * [FTimePickerStyle] for customizing a time picker's appearance.
class FTimePicker extends StatefulWidget {
  /// The controller.
  final FTimePickerController? controller;

  /// The style. If null, the default picker style will be used.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create time-picker
  /// ```
  final FTimePickerStyle Function(FTimePickerStyle style)? style;

  /// True if the time picker should use the 24-hour format.
  ///
  /// Setting this to false will use the locale's default format, which may be 24-hours. Defaults to false.
  final bool hour24;

  /// The interval between hours in the picker. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [hourInterval] < 1.
  final int hourInterval;

  /// The interval between minutes in the picker. Defaults to 5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [minuteInterval] < 1.
  final int minuteInterval;

  /// Handler called when the time picker's time changes.
  final ValueChanged<FTime>? onChange;

  /// Creates a [FTimePicker].
  const FTimePicker({
    this.controller,
    this.style,
    this.hour24 = false,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    this.onChange,
    super.key,
  }) : assert(0 < hourInterval, 'hourInterval ($hourInterval) must be > 0'),
       assert(0 < minuteInterval, 'minuteInterval ($minuteInterval) must be > 0');

  @override
  State<FTimePicker> createState() => _FTimePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('hour24', value: hour24, ifTrue: '24-hour'))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }
}

class _FTimePickerState extends State<FTimePicker> {
  late FTimePickerController _controller;
  late DateFormat format;
  late int padding;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FTimePickerController();
    _controller.addListener(_onChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(covariant FTimePicker old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        old.controller?.removeListener(_onChange);
      }

      _controller = widget.controller ?? FTimePickerController();
      _controller.addListener(_onChange);
    }

    _update();
  }

  void _onChange() => widget.onChange?.call(_controller.value);

  void _update() {
    final locale = FLocalizations.of(context) ?? FDefaultLocalizations();

    format = widget.hour24 ? DateFormat.Hm(locale.localeName) : DateFormat.jm(locale.localeName);
    padding = format.pattern!.contains(RegExp('HH|hh')) ? 2 : 0;

    // This behavior isn't ideal since changing the hour/minute interval causes an unintuitive time to be shown.
    // It is difficult to fix without FixedExtentScrollController exposing the keepOffset parameter.
    // See https://github.com/flutter/flutter/issues/162972
    _controller
      ..pattern = format.pattern!
      ..hours24 = !format.pattern!.contains('a')
      ..hourInterval = widget.hourInterval
      ..minuteInterval = widget.minuteInterval;

    _controller.picker?.dispose();
    _controller.picker = FPickerController(initialIndexes: _controller.encode(_controller.value));
    _controller.picker?.addListener(() => _controller.decode());
  }

  @override
  Widget build(BuildContext context) => TimePicker(
    controller: _controller,
    style: widget.style?.call(context.theme.timePickerStyle) ?? context.theme.timePickerStyle,
    format: format,
    padding: padding,
    hourInterval: _controller.hourInterval,
    minuteInterval: _controller.minuteInterval,
  );

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
    properties
      ..add(DiagnosticsProperty('controller', _controller))
      ..add(DiagnosticsProperty('format', format))
      ..add(IntProperty('padding', padding));
  }
}

/// The style of a time picker.
class FTimePickerStyle extends FPickerStyle with _$FTimePickerStyleFunctions {
  /// The padding.
  @override
  final EdgeInsetsDirectional padding;

  /// Creates a [FTimePickerStyle].
  const FTimePickerStyle({
    required super.textStyle,
    required super.selectionBorderRadius,
    required super.selectionColor,
    required super.focusedOutlineStyle,
    super.diameterRatio,
    super.squeeze,
    super.magnification,
    super.overAndUnderCenterOpacity,
    super.spacing = 0,
    super.textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
    super.selectionHeightAdjustment = 5,
    this.padding = const EdgeInsetsDirectional.only(start: 10, end: 10),
  });

  /// Creates a [FTimePickerStyle] that inherits its properties.
  FTimePickerStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
    : this(
        textStyle: typography.base.copyWith(fontWeight: FontWeight.w500),
        selectionBorderRadius: style.borderRadius,
        selectionColor: colors.muted,
        selectionHeightAdjustment: 5,
        spacing: 2,
        focusedOutlineStyle: style.focusedOutlineStyle,
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
      );
}
