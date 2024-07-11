part of '../../calendar.dart';

@internal
class PagedMonthPicker extends PagedPicker {
  final ValueChanged<LocalDate> onPress;

  PagedMonthPicker({
    required this.onPress,
    required super.style,
    required super.start,
    required super.end,
    required super.today,
    required super.initial,
    super.key,
  }) : super(enabledPredicate: (date) => start <= date && date <= end);

  @override
  State<PagedMonthPicker> createState() => _PagedMonthPickerState();
}

class _PagedMonthPickerState extends PagedPickerState<PagedMonthPicker> {
  late TextDirection _textDirection;

  @override
  Widget buildItem(BuildContext context, int page) => MonthPicker(
    style: widget.style.yearMonthPickerStyle,
    currentYear: widget.initial,
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
        final currentMonth = widget.today.truncate(to: DateUnit.months);
        focusedDate = _focusableMonth(widget.initial.year == widget.today.year ? currentMonth : current);
      }
    });
  }

  @override
  void handlePageChange(int page) {
    setState(() {
      print('handlePageChange');
      // final changed = widget.start.truncate(to: DateUnit.years).plus(years: page * yearMonthPickerItems);
      // if (current == changed) {
      //   return;
      // }
      //
      // current = changed;
      // if (focusedDate case final focused? when focused.truncate(to: DateUnit.years) == current) {
      //   // We have navigated to a new page with the grid focused, but the
      //   // focused year is not in this page. Choose a new one.
      //   focusedDate = _focusableMonth(current, focusedDate!);
      // }

      SemanticsService.announce(
        current.toString(), // TODO: localization
        _textDirection,
      );
    });
  }

  LocalDate? _focusableMonth(LocalDate preferredMonth) {
    final end = widget.initial.plus(years: 1);
    if (widget.initial <= preferredMonth && preferredMonth < end) {
      return preferredMonth;
    }

    for (var newFocus = widget.initial; newFocus < end; newFocus = newFocus.plus(months: 1)) {
      if (widget.enabledPredicate(newFocus)) {
        return newFocus;
      }
    }

    return null;
  }

  @override
  int delta(LocalDate start, LocalDate end) => 0;

  @override
  Map<TraversalDirection, Period> get directionOffset => const {
    TraversalDirection.up: Period(months: -yearMonthPickerColumns),
    TraversalDirection.right: Period(months: 1),
    TraversalDirection.down: Period(months: yearMonthPickerColumns),
    TraversalDirection.left: Period(months: -1),
  };
}