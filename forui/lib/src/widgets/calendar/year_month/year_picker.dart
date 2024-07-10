part of '../calendar.dart';

/// The number of columns in a year & month picker.
@internal
const yearMonthPickerColumns = 3;

/// The number of rows in a year & month picker.
@internal
const yearMonthPickerRows = 4;

/// The total number of items in a year & month picker.
@internal
const yearMonthPickerItems = yearMonthPickerColumns * yearMonthPickerRows;

@internal
class YearPicker extends StatefulWidget {
  final FCalendarYearMonthPickerStyle style;
  final LocalDate startYear;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate? focused;
  final ValueChanged<LocalDate> onPress;

  const YearPicker({
    required this.style,
    required this.startYear,
    required this.start,
    required this.end,
    required this.today,
    required this.focused,
    required this.onPress,
    super.key,
  });

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  late List<FocusNode> _years;

  @override
  void initState() {
    super.initState();
    _years = List.generate(yearMonthPickerItems, (i) => FocusNode(skipTraversal: true, debugLabel: '$i'));

    final focused = widget.focused;


    if (focused == null || focused < widget.startYear || widget.startYear.plus(years: yearMonthPickerItems) <= focused) {
      return;
    }

    _years[focused.year - widget.startYear.year].requestFocus();
  }

  @override
  Widget build(BuildContext context) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: yearMonthPickerColumns,
          childAspectRatio: 1.618,
        ),
        children: [
          for (var year = widget.startYear, i = 0; i < yearMonthPickerItems; year = year.plus(years: 1), i++)
            yearMonth(
              widget.style,
              year,
              _years[i],
              widget.onPress,
              (date) => '${date.year}', // TODO: localize
              enabled: widget.start <= year && year <= widget.end,
              current: widget.today.year == year.year,
            ),
        ],
      );

  @override
  void didUpdateWidget(YearPicker old) {
    super.didUpdateWidget(old);
    assert(
      old.startYear == widget.startYear,
      'We assumed that a new YearPicker is created each time we navigate to a years page.',
    );

    final focused = widget.focused;
    if (focused == null || focused < widget.startYear || widget.startYear.plus(years: yearMonthPickerItems) <= focused) {
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
