part of '../../calendar.dart';

@internal
class MonthPicker extends StatefulWidget {
  final FCalendarYearMonthPickerStyle style;
  final LocalDate currentYear;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate? focused;
  final ValueChanged<LocalDate> onPress;

  const MonthPicker({
    required this.style,
    required this.currentYear,
    required this.start,
    required this.end,
    required this.today,
    required this.focused,
    required this.onPress,
    super.key,
  });

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

    final focused = widget.focused;
    if (focused != null) {
      _months[focused.month - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: yearMonthPickerColumns,
          childAspectRatio: 1.618,
        ),
        children: [
          for (var month = widget.currentYear, i = 0; i < 12; month = month.plus(months: 1), i++)
            yearMonth(
              widget.style,
              month,
              _months[i],
              widget.onPress,
              (date) => '${date.month}', // TODO: localize
              enabled: widget.start <= month && month <= widget.end,
              current: widget.today.truncate(to: DateUnit.months) == month,
            ),
        ],
      );

  @override
  void didUpdateWidget(MonthPicker old) {
    super.didUpdateWidget(old);
    assert(
      old.currentYear == widget.currentYear,
      'We assumed that a new YearPicker is created each time we navigate to a years page.',
    );

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
