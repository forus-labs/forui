import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_picker/time_picker_controller.dart';

@internal
abstract class TimePicker extends StatelessWidget {
  final FTimePickerController controller;
  final FPickerStyle style;
  final DateFormat format;
  final int padding;
  final int hourInterval;
  final int minuteInterval;

  const TimePicker._({
    required this.controller,
    required this.style,
    required this.format,
    required this.padding,
    required this.hourInterval,
    required this.minuteInterval,
  });

  factory TimePicker({
    required FTimePickerController controller,
    required FPickerStyle style,
    required DateFormat format,
    required int padding,
    required int hourInterval,
    required int minuteInterval,
  }) => switch ((easternLocales.contains(format.locale), format.pattern!.contains('a'))) {
    (false, true) => _Western12Picker.new,
    (false, false) => _Western24Picker.new,
    (true, true) => _Eastern12Picker.new,
    (true, false) => _Eastern24Picker.new,
  }(
    controller: controller,
    style: style,
    format: format,
    padding: padding,
    hourInterval: hourInterval,
    minuteInterval: minuteInterval,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('format', format))
      ..add(IntProperty('padding', padding))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval));
  }
}

class _HourPicker extends StatefulWidget with FPickerWheelMixin {
  final FTimePickerController controller;
  final Widget child;

  const _HourPicker({required this.controller, required this.child});

  @override
  State<_HourPicker> createState() => _HourPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

class _HourPickerState extends State<_HourPicker> {
  int? _previous;

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollUpdateNotification>(
    onNotification: (notification) {
      final picker = widget.controller.picker!;
      final current = picker.wheels.first.selectedItem % 12;
      final am = picker.wheels.last;
      final next = am.selectedItem.isEven ? 1 : 0;

      if (!widget.controller.mutating && ((_previous == 11 && current == 0) || (_previous == 0 && current == 11))) {
        am.animateToItem(next, duration: const Duration(milliseconds: 100), curve: Curves.decelerate);
      }

      _previous = current;
      return false;
    },
    child: widget.child,
  );
}

class _Western12Picker extends TimePicker {
  const _Western12Picker({
    required super.controller,
    required super.style,
    required super.format,
    required super.padding,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    // Do NOT try to separate the date returned by format by whitespace. Certain locales, i.e. en_US on certain
    // platforms such as Chrome uses a narrow NBSP.
    final period = DateFormat('a', format.locale);
    return FPicker(
      controller: controller.picker,
      style: style,
      children: [
        _HourPicker(
          controller: controller,
          child: FPickerWheel.builder(
            builder: (_, index) {
              final hour = (index * hourInterval) % 12;
              return Text('${hour == 0 ? 12 : hour}'.padLeft(padding, '0'));
            },
          ),
        ),
        const Text(':'),
        FPickerWheel.builder(builder: (_, index) => Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
        FPickerWheel(
          children: [
            Text(period.format(DateTime.utc(1970, 1, 1, 1))),
            Text(period.format(DateTime.utc(1970, 1, 1, 13))),
          ],
        ),
      ],
    );
  }
}

class _Western24Picker extends TimePicker {
  const _Western24Picker({
    required super.controller,
    required super.style,
    required super.format,
    required super.padding,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) => FPicker(
    controller: controller.picker,
    style: style,
    children: [
      FPickerWheel.builder(builder: (_, index) => Text('${(index * hourInterval) % 24}'.padLeft(padding, '0'))),
      const Text(':'),
      FPickerWheel.builder(builder: (_, index) => Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
    ],
  );
}

class _Eastern12Picker extends TimePicker {
  const _Eastern12Picker({
    required super.controller,
    required super.style,
    required super.format,
    required super.padding,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final period = DateFormat('a', format.locale);
    return FPicker(
      controller: controller.picker,
      style: style,
      children: [
        _HourPicker(
          controller: controller,
          child: FPickerWheel.builder(
            builder: (_, index) {
              final time = format.format(DateTime(1970, 1, 1, (index * hourInterval) % 12));
              return Text(time.split(':').first);
            },
          ),
        ),
        const Text(':'),
        FPickerWheel.builder(
          builder: (_, index) {
            final time = format.format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60));
            return Text(time.split(':').last.split(' ').first);
          },
        ),
        FPickerWheel(
          children: [
            Text(period.format(DateTime.utc(1970, 1, 1, 1))),
            Text(period.format(DateTime.utc(1970, 1, 1, 13))),
          ],
        ),
      ],
    );
  }
}

class _Eastern24Picker extends TimePicker {
  const _Eastern24Picker({
    required super.controller,
    required super.style,
    required super.format,
    required super.padding,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) => FPicker(
    controller: controller.picker,
    style: style,
    children: [
      FPickerWheel.builder(
        builder: (_, index) {
          final time = format.format(DateTime(1970, 1, 1, (index * hourInterval) % 24));
          return Text(time.split(':').first);
        },
      ),
      const Text(':'),
      FPickerWheel.builder(
        builder: (_, index) {
          final time = format.format(DateTime(1970, 1, 1, (index * minuteInterval) % minuteInterval));
          return Text(time.split(':').last.split(' ').first);
        },
      ),
    ],
  );
}
