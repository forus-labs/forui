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
  final DateFormat format;

  factory TimeFieldController(FLocalizations localizations, DateFormat format, FTextFieldStyle style, FTime? time) {
    final placeholder = format.pattern!
        .replaceAll(RegExp('HH|H|hh|h'), 'HH')
        .replaceAll("'HH'", 'h') // fr_CA uses h to separate hour & minute
        .replaceAll(RegExp('mm'), 'MM')
        .replaceAll('a', '--');

    return TimeFieldController.test(
      localizations,
      format,
      style,
      placeholder,
      TextEditingValue(text: time == null ? placeholder : format.format(time.withDate(DateTime(1970)))),
    );
  }

  @visibleForTesting
  factory TimeFieldController.test(
    FLocalizations localizations,
    DateFormat format,
    FTextFieldStyle style,
    String placeholder,
    TextEditingValue value,
  ) => switch (format.pattern!.contains('a')) {
    true => Time12FieldController.new,
    false => Time24FieldController.new,
  }(localizations, format, style, TimeParser(format), placeholder, value);

  TimeFieldController.fromValue(this.format, super.style, super.parser, super.placeholder, super.value);
}
