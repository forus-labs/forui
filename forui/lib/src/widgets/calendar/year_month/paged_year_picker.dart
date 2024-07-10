part of '../calendar.dart';

@internal
class PagedYearPicker extends PagedPicker {
  final ValueChanged<LocalDate> onPress;

  PagedYearPicker({
    required this.onPress,
    required super.style,
    required super.start,
    required super.end,
    required super.today,
    required super.initial,
    super.key,
  }) : super(enabledPredicate: (date) => start <= date && date <= end);

  @override
  State<PagedYearPicker> createState() => _PagedYearPickerState();
}

class _PagedYearPickerState extends PagedPickerState<PagedYearPicker> {
  late TextDirection _textDirection;

  @override
  Widget buildItem(BuildContext context, int page) => YearPicker(
        style: widget.style.yearMonthPickerStyle,
        startYear: widget.start.truncate(to: DateUnit.years).plus(years: page * yearMonthPickerItems),
        start: widget.start,
        end: widget.end,
        today: widget.today,
        focused: focusedDate,
        onPress: widget.onPress,
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textDirection = Directionality.of(context);
  }

  @override
  void handleGridFocusChange(bool focused) {
    setState(() {
      if (focused && focusedDate == null) {
        final currentYear = widget.today.truncate(to: DateUnit.years);
        focusedDate = _focusableYear(current, currentYear == current ? currentYear : current);
      }
    });
  }

  @override
  void handlePageChange(int page) {
    setState(() {
      print('handled');

      final changed = widget.start.truncate(to: DateUnit.years).plus(years: page * yearMonthPickerItems);
      if (current == changed) {
        return;
      }

      current = changed;
      if (focusedDate case final focused? when focused.truncate(to: DateUnit.years) == current) {
        // We have navigated to a new page with the grid focused, but the
        // focused year is not in this page. Choose a new one.
        focusedDate = _focusableYear(current, focusedDate!);
      }

      SemanticsService.announce(
        current.toString(), // TODO: localization
        _textDirection,
      );
    });
  }

  LocalDate? _focusableYear(LocalDate startYear, LocalDate preferredYear) {
    final endYear = startYear.plus(years: yearMonthPickerItems);
    if (startYear <= preferredYear && preferredYear < endYear) {
      return preferredYear;
    }

    // Start at the 1st and take the first enabled date.
    for (var newFocus = startYear; newFocus < endYear; newFocus = newFocus.plus(years: 1)) {
      if (widget.enabledPredicate(newFocus)) {
        return newFocus;
      }
    }

    return null;
  }

  @override
  int delta(LocalDate start, LocalDate end) => ((end.year - start.year) / yearMonthPickerItems).floor();

  @override
  Map<TraversalDirection, Period> get directionOffset => const {
        TraversalDirection.up: Period(years: -yearMonthPickerColumns),
        TraversalDirection.right: Period(years: 1),
        TraversalDirection.down: Period(years: yearMonthPickerColumns),
        TraversalDirection.left: Period(years: -1),
      };
}
