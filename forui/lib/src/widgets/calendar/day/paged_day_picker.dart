part of '../calendar.dart';

@internal
class PagedDayPicker extends PagedPicker {
  final bool Function(LocalDate day) selectedPredicate;
  final ValueChanged<DateTime>? onMonthChange;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  PagedDayPicker({
    required this.selectedPredicate,
    required this.onMonthChange,
    required this.onPress,
    required this.onLongPress,
    required super.style,
    required super.start,
    required super.end,
    required super.today,
    required super.initial,
    required bool Function(LocalDate) enabledPredicate,
    super.key,
  }) : super(
          enabledPredicate: (date) => start <= date && date <= end && enabledPredicate(date),
        );

  @override
  State<PagedDayPicker> createState() => _PageDayPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedPredicate', selectedPredicate))
      ..add(DiagnosticsProperty('onMonthChange', onMonthChange))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

class _PageDayPickerState extends PagedPickerState<PagedDayPicker> {
  late TextDirection _textDirection;

  @override
  Widget buildItem(BuildContext context, int page) => DayPicker(
        focused: focusedDate,
        style: widget.style.dayPickerStyle,
        month: widget.start.truncate(to: DateUnit.months).plus(months: page),
        today: widget.today,
        enabledPredicate: widget.enabledPredicate,
        selectedPredicate: widget.selectedPredicate,
        onPress: (date) {
          setState(() => focusedDate = date);
          widget.onPress(date);
        },
        onLongPress: (date) {
          setState(() => focusedDate = date);
          widget.onLongPress(date);
        },
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textDirection = Directionality.of(context);
  }

  /// Handler for when the overall day grid obtains or loses focus.
  @override
  void handleGridFocusChange(bool focused) {
    setState(() {
      if (focused && focusedDate == null) {
        final preferred = widget.today.truncate(to: DateUnit.months) == current ? widget.today.day : 1;
        focusedDate = _focusableDayForMonth(current, preferred);
      }
    });
  }

  @override
  void handlePageChange(int page) {
    setState(() {
      final changed = widget.start.truncate(to: DateUnit.months).plus(months: page);
      if (current == changed) {
        return;
      }

      current = changed;
      widget.onMonthChange?.call(current.toNative());
      if (focusedDate case final focused? when focused.truncate(to: DateUnit.months) == current) {
        // We have navigated to a new month with the grid focused, but the
        // focused day is not in this month. Choose a new one trying to keep
        // the same day of the month.
        focusedDate = _focusableDayForMonth(current, focusedDate!.day);
      }

      SemanticsService.announce(
        current.toString(), // TODO: localization
        _textDirection,
      );
    });
  }

  /// Returns a focusable date for the given month.
  ///
  /// If the preferredDay is available in the month it will be returned,
  /// otherwise the first selectable day in the month will be returned. If
  /// no dates are selectable in the month, then it will return null.
  LocalDate? _focusableDayForMonth(LocalDate month, int preferredDay) {
    // Can we use the preferred day in this month?
    if (preferredDay <= month.daysInMonth) {
      final newFocus = month.copyWith(day: preferredDay);
      if (widget.enabledPredicate(newFocus)) {
        return newFocus;
      }
    }

    // Start at the 1st and take the first enabled date.
    for (var newFocus = month; newFocus.month == month.month; newFocus = newFocus.tomorrow) {
      if (widget.enabledPredicate(newFocus)) {
        return newFocus;
      }
    }

    return null;
  }

  @override
  int delta(LocalDate start, LocalDate end) => (end.year - start.year) * 12 + end.month - start.month;

  @override
  Map<TraversalDirection, Period> get directionOffset => const {
        TraversalDirection.up: Period(days: -DateTime.daysPerWeek),
        TraversalDirection.right: Period(days: 1),
        TraversalDirection.down: Period(days: DateTime.daysPerWeek),
        TraversalDirection.left: Period(days: -1),
      };
}
