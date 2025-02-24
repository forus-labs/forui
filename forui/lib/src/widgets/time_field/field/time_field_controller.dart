import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/field/field_controller.dart';
import 'package:forui/src/widgets/time_field/field/time_parser.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@internal
abstract class TimeFieldController extends FieldController {
  final FLocalizations _localizations;
  final DateFormat _format;
  final RegExp _suffix;

  factory TimeFieldController(FTime? time, FLocalizations localizations, DateFormat format, FTextFieldStyle style) {
    final placeholder = format.pattern!
        .replaceAll(RegExp('HH|H|hh|h'), 'HH')
        .replaceAll("'HH'", 'h') // fr_CA uses h to separate hour & minute
        .replaceAll(RegExp('mm'), 'MM')
        .replaceAll('a', '--');

    return switch (format.pattern!.contains('a')) {
      true => _Time12FieldController.new,
      false => _Time24FieldController.new,
    }(
      localizations,
      format,
      RegExp(RegExp.escape(localizations.timeFieldSuffix) + r'$'),
      style,
      TimeParser(format),
      placeholder,
      TextEditingValue(text: time == null ? placeholder : format.format(time.withDate(DateTime(1970)))),
    );
  }

  TimeFieldController._(
    this._localizations,
    this._format,
    this._suffix,
    super.style,
    super.parser,
    super.placeholder,
    super.value,
  );

  void traverse({required bool forward});

  void adjust(int adjustment);
}

class _Time12FieldController extends TimeFieldController {
  _Time12FieldController(
    super._localizations,
    super._format,
    super._suffix,
    super.style,
    super.parser,
    super.placeholder,
    super.value,
  ) : super._();

  @override
  void traverse({required bool forward}) {
    // TODO: implement traverse
  }

  @override
  void adjust(int adjustment) {
    // TODO: implement adjust
  }

  @override
  TextEditingValue selectParts(TextEditingValue value) {
    // TODO: implement selectParts
    throw UnimplementedError();
  }

  @override
  TextEditingValue updatePart(List<String> parts, int index) {
    // TODO: implement updatePart
    throw UnimplementedError();
  }

  @override
  List<String> split(String raw) {
    final truncated = raw.replaceAll(_suffix, '');

    // These locales do not have a separator between the time and period.
    if (_localizations.localeName == 'zh_HK' || _localizations.localeName == 'zh_TW') {
      return [truncated.substring(0, 2), ...truncated.substring(2).split(_localizations.timeFieldTimeSeparator)];
    }

    if (_format.pattern!.startsWith('a')) {
      final periodTime = truncated.split(_localizations.timeFieldPeriodSeparator);
      return [periodTime[0], ...periodTime[1].split(_localizations.timeFieldTimeSeparator)];
    }

    final timePeriod = truncated.split(_localizations.timeFieldPeriodSeparator);
    return [
      ...timePeriod[0].split(_localizations.timeFieldTimeSeparator),
      timePeriod.skip(1).join(_localizations.timeFieldPeriodSeparator),
    ];
  }

  @override
  String join(List<String> parts) {
    if (_format.pattern!.startsWith('a')) {
      return parts[0] +
          _localizations.timeFieldPeriodSeparator +
          parts[1] +
          _localizations.timeFieldTimeSeparator +
          parts[2] +
          _localizations.timeFieldSuffix;
    } else {
      return parts[0] +
          _localizations.timeFieldTimeSeparator +
          parts[1] +
          _localizations.timeFieldPeriodSeparator +
          parts[2] +
          _localizations.timeFieldSuffix;
    }
  }
}

class _Time24FieldController extends TimeFieldController {
  _Time24FieldController(
    super._localizations,
    super._format,
    super._suffix,
    super.style,
    super.parser,
    super.placeholder,
    super.value,
  ) : super._();

  @override
  void traverse({required bool forward}) {
    // TODO: implement traverse
  }

  @override
  void adjust(int adjustment) {
    // TODO: implement adjust
  }

  @override
  TextEditingValue selectParts(TextEditingValue value) {
    // TODO: implement selectParts
    throw UnimplementedError();
  }

  @override
  TextEditingValue updatePart(List<String> parts, int index) {
    // TODO: implement updatePart
    throw UnimplementedError();
  }

  @override
  List<String> split(String raw) => raw.replaceAll(_suffix, '').split(_localizations.timeFieldTimeSeparator);

  @override
  String join(List<String> parts) =>
      parts[0] + _localizations.timeFieldTimeSeparator + parts[1] + _localizations.timeFieldSuffix;
}
