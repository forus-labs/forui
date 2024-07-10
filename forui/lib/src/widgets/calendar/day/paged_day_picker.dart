part of '../calendar.dart';

@internal
class PagedDayPicker extends StatefulWidget {
  final FCalendarStyle style; // TODO: retrieve via context
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate initialMonth;
  final bool Function(LocalDate day) enabledPredicate;
  final bool Function(LocalDate day) selectedPredicate;
  final ValueChanged<DateTime>? onMonthChange;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  const PagedDayPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.initialMonth,
    required this.enabledPredicate,
    required this.selectedPredicate,
    required this.onMonthChange,
    required this.onPress,
    required this.onLongPress,
    super.key,
  });

  @override
  State<PagedDayPicker> createState() => _PageDayPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('initialMonth', initialMonth))
      ..add(DiagnosticsProperty('enabledPredicate', enabledPredicate))
      ..add(DiagnosticsProperty('selectedPredicate', selectedPredicate))
      ..add(DiagnosticsProperty('onMonthChange', onMonthChange))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

// Most of the traversal logic is copied from Material's _MonthPickerState.
class _PageDayPickerState extends State<PagedDayPicker> {
  static int delta(LocalDate start, LocalDate end) => (end.year - start.year) * 12 + end.month - start.month;

  static const _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowLeft): DirectionalFocusIntent(TraversalDirection.left),
    SingleActivator(LogicalKeyboardKey.arrowRight): DirectionalFocusIntent(TraversalDirection.right),
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  static const _directionOffset = <TraversalDirection, int>{
    TraversalDirection.up: -DateTime.daysPerWeek,
    TraversalDirection.right: 1,
    TraversalDirection.down: DateTime.daysPerWeek,
    TraversalDirection.left: -1,
  };

  final GlobalKey _pageViewKey = GlobalKey();
  late LocalDate _currentMonth;
  late PageController _controller;
  late TextDirection _textDirection;
  late Map<Type, Action<Intent>> _actions;
  late FocusNode _dayGridFocus;
  LocalDate? _focusedDay;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth;
    _controller = PageController(initialPage: delta(widget.start, widget.initialMonth));
    _actions = {
      NextFocusIntent: CallbackAction<NextFocusIntent>(onInvoke: _handleGridNextFocus),
      PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(onInvoke: _handleGridPreviousFocus),
      DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(onInvoke: _handleDirectionFocus),
    };
    _dayGridFocus = FocusNode(debugLabel: 'Day Grid');
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Controls(
        style: widget.style.headerStyle,
        onPrevious: _first ? null : _handlePreviousMonth,
        onNext: _last ? null : _handleNextMonth,
      ),
      Expanded(
        child: FocusableActionDetector(
          shortcuts: _shortcuts,
          actions: _actions,
          focusNode: _dayGridFocus,
          onFocusChange: _handleGridFocusChange,
          child: PageView.builder(
            key: _pageViewKey,
            controller: _controller,
            itemBuilder: (context, index) => DayPicker(
                focused: _focusedDay,
                style: widget.style.dayPickerStyle,
                month: widget.start.truncate(to: DateUnit.months).plus(months: index),
                today: widget.today,
                enabledPredicate: (date) =>
                    widget.start <= date && date <= widget.end && widget.enabledPredicate(date),
                selectedPredicate: widget.selectedPredicate,
                onPress: (date) {
                  setState(() => _focusedDay = date);
                  widget.onPress(date);
                },
                onLongPress: (date) {
                  setState(() => _focusedDay = date);
                  widget.onLongPress(date);
                },
              ),
            itemCount: delta(widget.start, widget.end),
            onPageChanged: _handleMonthPageChanged,
          ),
        ),
      ),
    ],
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textDirection = Directionality.of(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    _dayGridFocus.dispose();
    super.dispose();
  }

  /// Navigate to the next month.
  void _handleNextMonth() {
    if (!_last) {
      _controller.nextPage(
        duration: widget.style.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  /// Navigate to the previous month.
  void _handlePreviousMonth() {
    if (!_first) {
      _controller.previousPage(
        duration: widget.style.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  /// True if the earliest allowable month is displayed.
  bool get _first => widget.start.truncate(to: DateUnit.months) == _currentMonth;

  /// True if the latest allowable month is displayed.
  bool get _last => widget.end.truncate(to: DateUnit.months) == _currentMonth;

  /// Navigate to the given month.
  void _showMonth(LocalDate month, {bool jump = false}) {
    final page = delta(widget.start, month);
    if (jump) {
      _controller.jumpToPage(page);
    } else {
      _controller.animateToPage(
        page,
        duration: widget.style.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  void _handleMonthPageChanged(int page) {
    setState(() {
      final changed = widget.start.truncate(to: DateUnit.months).plus(months: page);
      if (_currentMonth == changed) {
        return;
      }

      _currentMonth = changed;
      widget.onMonthChange?.call(_currentMonth.toNative());
      if (_focusedDay case final focused? when focused.truncate(to: DateUnit.months) == _currentMonth) {
        // We have navigated to a new month with the grid focused, but the
        // focused day is not in this month. Choose a new one trying to keep
        // the same day of the month.
        _focusedDay = _focusableDayForMonth(_currentMonth, _focusedDay!.day);
      }

      SemanticsService.announce(
        _currentMonth.toString(), // TODO: localization
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

  /// Handler for when the overall day grid obtains or loses focus.
  void _handleGridFocusChange(bool focused) {
    setState(() {
      if (focused && _focusedDay == null) {
        final preferred = widget.today.truncate(to: DateUnit.months) == _currentMonth ? widget.today.day : 1;
        _focusedDay = _focusableDayForMonth(_currentMonth, preferred);
      }
    });
  }

  /// Move focus to the next element after the day grid.
  void _handleGridNextFocus(NextFocusIntent intent) {
    _dayGridFocus
      ..requestFocus()
      ..nextFocus();
  }

  /// Move focus to the previous element before the day grid.
  void _handleGridPreviousFocus(PreviousFocusIntent intent) {
    _dayGridFocus
      ..requestFocus()
      ..previousFocus();
  }

  /// Move the internal focus date in the direction of the given intent.
  ///
  /// This will attempt to move the focused day to the next selectable day in
  /// the given direction. If the new date is not in the current month, then
  /// the page view will be scrolled to show the new date's month.
  ///
  /// For horizontal directions, it will move forward or backward a day (depending
  /// on the current [TextDirection]). For vertical directions it will move up and
  /// down a week at a time.
  void _handleDirectionFocus(DirectionalFocusIntent intent) {
    assert(_focusedDay != null, 'Cannot move focus without a focused day.');
    setState(() {
      final nextDate = _nextDateInDirection(_focusedDay!, intent.direction);
      if (nextDate != null) {
        _focusedDay = nextDate;
        if (_focusedDay?.truncate(to: DateUnit.months) != _currentMonth) {
          _showMonth(_focusedDay!);
        }
      }
    });
  }

  // Swap left and right if the text direction if RTL
  int _dayDirectionOffset(TraversalDirection traversalDirection, TextDirection textDirection) =>
      _directionOffset[switch ((traversalDirection, textDirection)) {
        (TraversalDirection.left, TextDirection.rtl) => TraversalDirection.right,
        (TraversalDirection.right, TextDirection.rtl) => TraversalDirection.left,
        _ => traversalDirection,
      }]!;

  LocalDate? _nextDateInDirection(LocalDate date, TraversalDirection direction) {
    final textDirection = Directionality.of(context);

    var next = date.plus(days: _dayDirectionOffset(direction, textDirection));
    while (widget.start <= next && next <= widget.end) {
      if (widget.enabledPredicate(next)) {
        return next;
      }

      next = date.plus(days: _dayDirectionOffset(direction, textDirection));
    }

    return null;
  }
}
