import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/input_controller.dart';
import 'package:forui/src/widgets/time_field/input/time_12_input_controller.dart';
import 'package:forui/src/widgets/time_field/input/time_24_input_controller.dart';
import 'package:forui/src/widgets/time_field/input/time_parser.dart';

@internal
abstract class TimeInputController extends InputController {
  final FTimeFieldController controller;
  final DateFormat format;

  factory TimeInputController(
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

    return .test(localizations, controller, format, style, placeholder, TextEditingValue(text: time));
  }

  @visibleForTesting
  factory TimeInputController.test(
    FLocalizations localizations,
    FTimeFieldController controller,
    DateFormat format,
    FTextFieldStyle style,
    String placeholder,
    TextEditingValue value,
  ) => switch (format.pattern!.contains('a')) {
    true => Time12InputController.new,
    false => Time24InputController.new,
  }(localizations, controller, format, value, style, TimeParser(format), placeholder);

  TimeInputController.fromValue(
    this.controller,
    this.format,
    super.value,
    super.style,
    super.parser,
    super.placeholder,
  ) {
    controller.addListener(updateFromTimeController);
  }

  // Used for input-driven changes only.
  @override
  set rawValue(TextEditingValue newValue) {
    // Allow selection & arrow key traversal
    if (super.rawValue.text == newValue.text) {
      super.rawValue = newValue;
      return;
    }

    final dateTime = format.tryParseStrict(newValue.text, true);
    final proposed = dateTime == null ? null : FTime.fromDateTime(dateTime);
    if (proposed == controller.value) {
      // Prevent toggling controller.value.
      super.rawValue = newValue;
      return;
    }

    controller.value = proposed;
    if (controller.value == proposed) {
      super.rawValue = newValue;
    }
  }

  @visibleForTesting
  void updateFromTimeController() {
    if (!mutating) {
      super.rawValue = selector.map(
        rawValue,
        TextEditingValue(
          text: switch (controller.value) {
            null => placeholder,
            final value => format.format(value.withDate(DateTime(1970))),
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(updateFromTimeController);
    super.dispose();
  }
}
