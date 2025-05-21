import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/shared/entry.dart';

@internal
class YearPicker extends StatefulWidget {
  static const columns = 3;
  static const rows = 5;
  static const items = columns * rows;

  final FCalendarEntryStyle yearMonthStyle;
  final FCalendarDayPickerStyle dayStyle;
  final LocalDate startYear;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate? focused;
  final ValueChanged<LocalDate> onPress;

  YearPicker({
    required this.yearMonthStyle,
    required this.dayStyle,
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
      ..add(DiagnosticsProperty('yearMonthStyle', yearMonthStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dayStyle', dayStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('startYear', startYear, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('start', start, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('end', end, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('today', today, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focused', focused, level: DiagnosticLevel.debug))
      ..add(ObjectFlagProperty.has('onPress', onPress, level: DiagnosticLevel.debug));
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: YearPicker.columns,
        mainAxisExtent: ((widget.dayStyle.tileSize - 5.0) * DayPicker.maxRows) / YearPicker.rows,
        mainAxisSpacing: 5.0,
      ),
      children: [
        for (var year = widget.startYear, i = 0; i < YearPicker.items; year = year.plus(years: 1), i++)
          Entry.yearMonth(
            style: widget.yearMonthStyle,
            date: year,
            focusNode: _years[i],
            current: widget.today.year == year.year,
            selectable: widget.start <= year && year <= widget.end,
            format: (date) => (FLocalizations.of(context) ?? FDefaultLocalizations()).year(date.toNative()),
            onPress: widget.onPress,
          ),
      ],
    ),
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
