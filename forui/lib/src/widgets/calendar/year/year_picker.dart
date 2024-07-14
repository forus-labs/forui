import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/src/widgets/calendar/shared/entry.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';

@internal
class YearPicker extends StatefulWidget {
  static const columns = 3;
  static const rows = 4;
  static const items = columns * rows;

  final FCalendarYearMonthPickerStyle style;
  final LocalDate startYear;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate? focused;
  final ValueChanged<LocalDate> onPress;

  YearPicker({
    required this.style,
    required this.startYear,
    required this.start,
    required this.end,
    required this.today,
    required this.focused,
    required this.onPress,
    super.key,
  }) : assert(startYear == startYear.truncate(to: DateUnit.years), 'startYear must be truncated to years.');

  @override
  State<YearPicker> createState() => _YearPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('startYear', startYear, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('start', start, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('end', end, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('today', today, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focused', focused, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug));
  }
}

class _YearPickerState extends State<YearPicker> {
  late List<FocusNode> _years;

  @override
  void initState() {
    super.initState();
    _years = List.generate(YearPicker.items, (i) => FocusNode(skipTraversal: true, debugLabel: '$i'));

    final focused = widget.focused;
    if (focused == null || focused < widget.startYear || widget.startYear.plus(years: YearPicker.items) <= focused) {
      return;
    }

    _years[focused.year - widget.startYear.year].requestFocus();
  }

  @override
  Widget build(BuildContext context) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: YearPicker.columns,
          childAspectRatio: 1.618,
        ),
        children: [
          for (var year = widget.startYear, i = 0; i < YearPicker.items; year = year.plus(years: 1), i++)
            Entry.yearMonth(
              style: widget.style,
              date: year,
              focusNode: _years[i],
              current: widget.today.year == year.year,
              enabled: widget.start <= year && year <= widget.end,
              format: (date) => '${date.year}', // TODO: localization
              onPress: widget.onPress,
            ),
        ],
      );

  @override
  void didUpdateWidget(YearPicker old) {
    super.didUpdateWidget(old);
    assert(old.startYear == widget.startYear, 'startYear must noe change.');

    final focused = widget.focused;
    if (focused == null || focused < widget.startYear || widget.startYear.plus(years: YearPicker.items) <= focused) {
      return;
    }

    if (_years[focused.year - widget.startYear.year] case final focusNode when old.focused != widget.focused) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _years) {
      node.dispose();
    }
    super.dispose();
  }
}
