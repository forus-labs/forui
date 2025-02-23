import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_picker/picker.dart';
import 'package:forui/src/widgets/time_picker/time_picker_controller.dart';

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
/// * [FPickerStyle] for customizing a time picker's appearance.
class FTimePicker extends StatefulWidget {
  /// The controller.
  final FTimePickerController? controller;

  /// The style. If null, the default picker style will be used.
  final FPickerStyle? style;

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

  /// Creates a [FTimePicker].
  const FTimePicker({
    this.controller,
    this.style,
    this.hour24 = false,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    super.key,
  }) : assert(0 < hourInterval, 'hourInterval cannot be less than 1'),
       assert(0 < minuteInterval, 'minuteInterval cannot be less than 1');

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
      ..add(IntProperty('minuteInterval', minuteInterval));
  }
}

class _FTimePickerState extends State<FTimePicker> {
  late FTimePickerController controller;
  late DateFormat format;
  late int padding;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? FTimePickerController();
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
        controller.dispose();
      }

      controller = widget.controller ?? FTimePickerController();
    }

    _update();
  }

  void _update() {
    final locale = FLocalizations.of(context) ?? FDefaultLocalizations();

    format = widget.hour24 ? DateFormat.Hm(locale.localeName) : DateFormat.jm(locale.localeName);
    padding = format.pattern!.contains(RegExp('HH|hh')) ? 2 : 0;

    // This behavior isn't ideal since changing the hour/minute interval causes an unintuitive time to be shown.
    // It is difficult to fix without FixedExtentScrollController exposing the keepOffset parameter.
    // See https://github.com/flutter/flutter/issues/162972
    controller
      ..pattern = format.pattern!
      ..hours24 = !format.pattern!.contains('a')
      ..hourInterval = widget.hourInterval
      ..minuteInterval = widget.minuteInterval;

    controller.picker?.dispose();
    controller.picker = FPickerController(initialIndexes: controller.encode(controller.value));
    controller.picker?.addListener(() => controller.decode());
  }

  @override
  Widget build(BuildContext context) => TimePicker(
    controller: controller,
    style: widget.style ?? context.theme.pickerStyle,
    format: format,
    padding: padding,
    hourInterval: controller.hourInterval,
    minuteInterval: controller.minuteInterval,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('format', format))
      ..add(IntProperty('padding', padding));
  }
}
