import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/field/field_controller.dart';
import 'package:forui/src/widgets/time_field/field/time_12_field_controller.dart';
import 'package:forui/src/widgets/time_field/field/time_24_field_controller.dart';
import 'package:forui/src/widgets/time_field/field/time_parser.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@internal
abstract class TimeFieldController extends FieldController {
  final FTimeFieldController controller;
  final DateFormat format;

  factory TimeFieldController(
    FLocalizations localizations,
    FTimeFieldController controller,
    DateFormat format,
    FTextFieldStyle style,
  ) {
    final placeholder = format.pattern!
        .replaceAll(RegExp('HH|H|hh|h'), 'HH')
        .replaceAll("'HH'", 'h') // fr_CA uses h to separate hour & minute
        .replaceAll(RegExp('mm'), 'MM')
        .replaceAll('a', '--')
        .replaceAll("'", '');
    final time = controller.value == null ? placeholder : format.format(controller.value!.withDate(DateTime(1970)));

    return TimeFieldController.test(
      localizations,
      controller,
      format,
      style,
      placeholder,
      TextEditingValue(text: time),
    );
  }

  @visibleForTesting
  factory TimeFieldController.test(
    FLocalizations localizations,
    FTimeFieldController controller,
    DateFormat format,
    FTextFieldStyle style,
    String placeholder,
    TextEditingValue value,
  ) => switch (format.pattern!.contains('a')) {
    true => Time12FieldController.new,
    false => Time24FieldController.new,
  }(localizations, controller, format, style, TimeParser(format), placeholder, value);

  TimeFieldController.fromValue(
    this.controller,
    this.format,
    super.style,
    super.parser,
    super.placeholder,
    super.value,
  ) {
    controller.addListener(updateFromTimeController);
  }

  @override
  void onValueChanged(String newValue) {
    final time = format.tryParseStrict(newValue, true);
    controller.value = time == null ? null : FTime.fromDateTime(time);
  }

  @visibleForTesting
  void updateFromTimeController() {
    if (!mutating) {
      rawValue = TextEditingValue(
        text: switch (controller.value) {
          null => placeholder,
          final value => format.format(value.withDate(DateTime(1970))),
        },
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(updateFromTimeController);
    super.dispose();
  }
}
