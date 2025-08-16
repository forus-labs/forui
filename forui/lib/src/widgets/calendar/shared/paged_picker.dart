import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/src/widgets/calendar/calendar.dart';
import 'package:forui/src/widgets/calendar/shared/header.dart';

@internal
abstract class PagedPicker extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate initial;
  final Predicate<LocalDate> selectable;

  PagedPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.initial,
    Predicate<LocalDate>? selectable,
    super.key,
  }) : selectable = ((date) => start <= date && date <= end && (selectable?.call(date) ?? true));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('initial', initial))
      ..add(ObjectFlagProperty.has('selectable', selectable));
  }
}

// Most of the traversal logic is copied from Material's _MonthPickerState.
@internal
abstract class PagedPickerState<T extends PagedPicker> extends State<T> {
  static const _shortcuts = {
    SingleActivator(LogicalKeyboardKey.arrowLeft): DirectionalFocusIntent(TraversalDirection.left),
    SingleActivator(LogicalKeyboardKey.arrowRight): DirectionalFocusIntent(TraversalDirection.right),
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  LocalDate? focusedDate;
  late LocalDate current;
  late TextDirection textDirection;
  late PageController _controller;
  late Key _key;
  late Map<Type, Action<Intent>> _actions;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    current = widget.initial;
    _controller = PageController(initialPage: delta(widget.start, widget.initial));
    _key = ValueKey((widget.start, widget.end));
    _actions = {
      NextFocusIntent: CallbackAction<NextFocusIntent>(onInvoke: _onGridNextFocus),
      PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(onInvoke: _onGridPreviousFocus),
      DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(onInvoke: _onDirectionFocus),
    };
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(T old) {
    super.didUpdateWidget(old);
    if (widget.start != old.start || widget.end != old.end) {
      _controller.dispose();
      _controller = PageController(initialPage: delta(widget.start, current));
      _key = ValueKey((widget.start, widget.end));
    }
  }

  @override
  Widget build(BuildContext _) => Column(
    children: [
      Navigation(
        style: widget.style.headerStyle,
        onPrevious: _first ? null : _onPrevious,
        onNext: _last ? null : _onNext,
      ),
      Expanded(
        child: FocusableActionDetector(
          shortcuts: _shortcuts,
          actions: _actions,
          focusNode: _focusNode,
          onFocusChange: onGridFocusChange,
          child: PageView.builder(
            key: _key,
            controller: _controller,
            itemBuilder: buildItem,
            itemCount: delta(widget.start, widget.end) + 1,
            onPageChanged: onPageChange,
          ),
        ),
      ),
    ],
  );

  Widget buildItem(BuildContext context, int page);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textDirection = Directionality.of(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('current', current))
      ..add(DiagnosticsProperty('focusedDate', focusedDate))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(DiagnosticsProperty('directionOffset', directionOffset));
  }

  void _onNext() {
    if (!_last) {
      _controller.nextPage(duration: widget.style.pageAnimationDuration, curve: Curves.ease);
    }
  }

  void _onPrevious() {
    if (!_first) {
      _controller.previousPage(duration: widget.style.pageAnimationDuration, curve: Curves.ease);
    }
  }

  bool get _first => delta(widget.start, current) == 0;

  bool get _last => delta(widget.start, current) == delta(widget.start, widget.end);

  void _showPage(LocalDate date) {
    final page = delta(widget.start, date);
    _controller.animateToPage(page, duration: widget.style.pageAnimationDuration, curve: Curves.ease);
  }

  void onPageChange(int page);

  // ignore: avoid_positional_boolean_parameters
  void onGridFocusChange(bool focused);

  /// Move focus to the next element after the day grid.
  void _onGridNextFocus(NextFocusIntent intent) {
    _focusNode
      ..requestFocus()
      ..nextFocus();
  }

  /// Move focus to the previous element before the day grid.
  void _onGridPreviousFocus(PreviousFocusIntent intent) {
    _focusNode
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
  void _onDirectionFocus(DirectionalFocusIntent intent) {
    assert(focusedDate != null, 'Cannot move focus without a focused day.');
    setState(() {
      if (_nextDate(focusedDate!, intent.direction) case final next?) {
        focusedDate = next;
        if (delta(widget.start, focusedDate!) != delta(widget.start, current)) {
          _showPage(focusedDate!);
        }
      }
    });
  }

  LocalDate? _nextDate(LocalDate date, TraversalDirection direction) {
    final textDirection = Directionality.of(context);
    final offset =
        directionOffset[switch ((direction, textDirection)) {
          (TraversalDirection.left, TextDirection.rtl) => TraversalDirection.right,
          (TraversalDirection.right, TextDirection.rtl) => TraversalDirection.left,
          _ => direction,
        }]!;

    var next = date + offset;
    while (widget.start <= next && next <= widget.end) {
      if (widget.selectable(next)) {
        return next;
      }

      next = date + offset;
    }

    return null;
  }

  int delta(LocalDate start, LocalDate end);

  Map<TraversalDirection, Period> get directionOffset;
}
