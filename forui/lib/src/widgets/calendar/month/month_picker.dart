import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/src/widgets/calendar/shared/entry.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';

// ignore: non_constant_identifier_names
final _MMM = DateFormat.MMM();

@internal
class MonthPicker extends StatefulWidget {
  static const columns = 3;

  final FCalendarYearMonthPickerStyle style;
  final LocalDate currentYear;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate? focused;
  final ValueChanged<LocalDate> onPress;

  MonthPicker({
    required this.style,
    required this.currentYear,
    required this.start,
    required this.end,
    required this.today,
    required this.focused,
    required this.onPress,
    super.key,
  }) : assert(currentYear == currentYear.truncate(to: DateUnit.years), 'currentYear must be truncated to years');

  @override
  State<MonthPicker> createState() => _MonthPickerState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('currentYear', currentYear, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('start', start, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('end', end, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('today', today, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focused', focused, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug));
  }
}

class _MonthPickerState extends State<MonthPicker> {
  late List<FocusNode> _months;

  @override
  void initState() {
    super.initState();
    _months = List.generate(12, (i) => FocusNode(skipTraversal: true, debugLabel: '$i'));

    if (widget.focused != null) {
      _months[widget.focused!.month - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MonthPicker.columns,
          childAspectRatio: 1.618,
        ),
        children: [
          for (var month = widget.currentYear, i = 0; i < 12; month = month.plus(months: 1), i++)
            Entry.yearMonth(
              style: widget.style,
              date: month,
              focusNode: _months[i],
              current: widget.today.truncate(to: DateUnit.months) == month,
              enabled: widget.start <= month && month <= widget.end,
              format: (date) => _MMM.format(date.toNative()), // TODO: localize
              onPress: widget.onPress,
            ),
        ],
      );

  @override
  void didUpdateWidget(MonthPicker old) {
    super.didUpdateWidget(old);
    assert(old.currentYear == widget.currentYear, 'currentYear must not change.');

    final focused = widget.focused;
    if (focused == null || focused < widget.currentYear || widget.currentYear.plus(years: 1) <= focused) {
      return;
    }

    if (_months[focused.month - 1] case final focusNode when old.focused != widget.focused) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _months) {
      node.dispose();
    }
    super.dispose();
  }
}
