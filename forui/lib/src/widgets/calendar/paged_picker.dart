part of 'calendar.dart';

@internal
abstract class PagedPicker extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate initial;
  final bool Function(LocalDate day) enabledPredicate;

  const PagedPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.initial,
    required this.enabledPredicate,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('initial', initial));
  }
}

// Most of the traversal logic is copied from Material's _MonthPickerState.
@internal
abstract class PagedPickerState<T extends PagedPicker> extends State<T> {

  static const _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowLeft): DirectionalFocusIntent(TraversalDirection.left),
    SingleActivator(LogicalKeyboardKey.arrowRight): DirectionalFocusIntent(TraversalDirection.right),
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  final GlobalKey _pageViewKey = GlobalKey();
  late LocalDate current;
  late PageController _controller;
  late Map<Type, Action<Intent>> _actions;
  late FocusNode _gridFocusNode;
  LocalDate? _focused;

  @override
  void initState() {
    super.initState();
    current = widget.initial;
    _controller = PageController(initialPage: delta(widget.start, widget.initial));
    _actions = {
      NextFocusIntent: CallbackAction<NextFocusIntent>(onInvoke: _handleGridNextFocus),
      PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(onInvoke: _handleGridPreviousFocus),
      DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(onInvoke: _handleDirectionFocus),
    };
    _gridFocusNode = FocusNode(debugLabel: 'Grid');
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Controls(
        style: widget.style.headerStyle,
        onPrevious: _first ? null : _handlePrevious,
        onNext: _last ? null : _handleNext,
      ),
      Expanded(
        child: FocusableActionDetector(
          shortcuts: _shortcuts,
          actions: _actions,
          focusNode: _gridFocusNode,
          onFocusChange: handleGridFocusChange,
          child: PageView.builder(
            key: _pageViewKey,
            controller: _controller,
            itemBuilder: buildItem,
            itemCount: delta(widget.start, widget.end),
            onPageChanged: handlePageChange,
          ),
        ),
      ),
    ],
  );

  Widget buildItem(BuildContext context, int index);

  @override
  void dispose() {
    _controller.dispose();
    _gridFocusNode.dispose();
    super.dispose();
  }


  void _handleNext() {
    if (!_last) {
      _controller.nextPage(duration: widget.style.pageAnimationDuration, curve: Curves.ease);
    }
  }

  void _handlePrevious() {
    if (!_first) {
      _controller.previousPage(duration: widget.style.pageAnimationDuration, curve: Curves.ease);
    }
  }

  bool get _first => delta(widget.start, current) == 0;

  bool get _last => delta(widget.start, current) == delta(widget.start, widget.end);

  /// Navigate to the given month.
  void _showPage(LocalDate date, {bool jump = false}) {
    final page = delta(widget.start, date);
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

  void handlePageChange(int page);

  void handleGridFocusChange(bool focused);


  /// Move focus to the next element after the day grid.
  void _handleGridNextFocus(NextFocusIntent intent) {
    _gridFocusNode
      ..requestFocus()
      ..nextFocus();
  }

  /// Move focus to the previous element before the day grid.
  void _handleGridPreviousFocus(PreviousFocusIntent intent) {
    _gridFocusNode
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
    assert(_focused != null, 'Cannot move focus without a focused day.');
    setState(() {
      final nextDate = _nextDateInDirection(_focused!, intent.direction);
      if (nextDate != null) {
        _focused = nextDate;
        if (delta(widget.start, _focused!) != delta(widget.start, current)) {
          _showPage(_focused!);
        }
      }
    });
  }

  // Swap left and right if the text direction if RTL
  Period _adjustDirectionOffset(TraversalDirection traversalDirection, TextDirection textDirection) =>
      directionOffset[switch ((traversalDirection, textDirection)) {
        (TraversalDirection.left, TextDirection.rtl) => TraversalDirection.right,
        (TraversalDirection.right, TextDirection.rtl) => TraversalDirection.left,
        _ => traversalDirection,
      }]!;

  LocalDate? _nextDateInDirection(LocalDate date, TraversalDirection direction) {
    final textDirection = Directionality.of(context);

    var next = date + _adjustDirectionOffset(direction, textDirection);
    while (widget.start <= next && next <= widget.end) {
      if (widget.enabledPredicate(next)) {
        return next;
      }

      next = date + _adjustDirectionOffset(direction, textDirection);
    }

    return null;
  }


  int delta(LocalDate start, LocalDate end);

  Map<TraversalDirection, Period> get directionOffset;
}
