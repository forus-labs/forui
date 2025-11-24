import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

typedef _Create<T> = FCalendarController<T> Function(_CalendarControllerHook<T>);

/// Creates a [FCalendarController] that allows only a single date to be selected and is automatically disposed.
///
/// [selectable] will always return true if not given.
///
/// [toggleable] determines whether the controller should unselect a date if it is already selected. Defaults to true.
///
/// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
/// dates in UTC timezone. Defaults to true.
///
/// ```dart
/// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
/// ```
///
/// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
/// the help of a 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
/// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
///
/// ## Contract
/// Throws [AssertionError] if [initialSelection] is not in UTC timezone and [truncateAndStripTimezone] is false.
FCalendarController<DateTime?> useFDateCalendarController({
  DateTime? initialSelection,
  bool Function(DateTime)? selectable,
  bool toggleable = false,
  bool truncateAndStripTimezone = true,
  List<Object?>? keys,
}) => use(
  _CalendarControllerHook<DateTime?>(
    value: initialSelection,
    selectable: selectable,
    toggleable: toggleable,
    debugLabel: 'useFDateCalendarController',
    create: (hook) => .date(
      initialSelection: hook.value,
      selectable: hook.selectable,
      toggleable: hook.toggleable,
      truncateAndStripTimezone: truncateAndStripTimezone,
    ),
  ),
);

/// Creates a [FCalendarController] that allows only multiple dates to be selected and is automatically disposed.
///
/// [selectable] will always return true if not given.
///
/// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
/// dates in UTC timezone. Defaults to true.
///
/// ```dart
/// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
/// ```
///
/// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
/// the help of an 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
/// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
///
/// ## Contract
/// Throws [AssertionError] if the dates in [initialSelections] are not in UTC timezone and [truncateAndStripTimezone]
/// is false.
FCalendarController<Set<DateTime>> useFDatesCalendarController({
  Set<DateTime> initialSelections = const {},
  bool Function(DateTime)? selectable,
  bool truncateAndStripTimezone = true,
  List<Object?>? keys,
}) => use(
  _CalendarControllerHook<Set<DateTime>>(
    value: initialSelections,
    selectable: selectable,
    debugLabel: 'useFDatesCalendarController',
    create: (hook) => .dates(
      initialSelections: hook.value,
      selectable: hook.selectable,
      truncateAndStripTimezone: truncateAndStripTimezone,
    ),
  ),
);

/// Creates a [FCalendarController] that allows a single range to be selected to be selected and is automatically
/// disposed.
///
/// [selectable] will always return true if not given.
///
/// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
/// dates in UTC timezone. Defaults to true.
///
/// ```dart
/// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
/// ```
///
/// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
/// the help of an 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
/// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
///
/// Both the start and end dates of the range is inclusive. Unselectable dates within the selected range are selected
/// regardless.
///
/// ## Contract
/// Throws [AssertionError] if:
/// * the given dates in [initialSelection] is not in UTC timezone and [truncateAndStripTimezone] is false.
/// * the end date is less than start date.
FCalendarController<(DateTime, DateTime)?> useFRangeCalendarController({
  (DateTime, DateTime)? initialSelection,
  bool Function(DateTime)? selectable,
  bool truncateAndStripTimezone = true,
  List<Object?>? keys,
}) => use(
  _CalendarControllerHook<(DateTime, DateTime)?>(
    value: initialSelection,
    selectable: selectable,
    debugLabel: 'useFRangeCalendarController',
    create: (hook) => .range(
      initialSelection: hook.value,
      selectable: hook.selectable,
      truncateAndStripTimezone: truncateAndStripTimezone,
    ),
  ),
);

class _CalendarControllerHook<T> extends Hook<FCalendarController<T>> {
  final T value;
  final bool Function(DateTime)? selectable;
  final bool toggleable;
  final String _debugLabel;
  final _Create<T> _create;

  const _CalendarControllerHook({
    required this.value,
    required this.selectable,
    required String debugLabel,
    required _Create<T> create,
    this.toggleable = false,
    super.keys,
  }) : _create = create,
       _debugLabel = debugLabel;

  @override
  _CalendarControllerHookState<T> createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('initialSelection', value))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable'));
  }
}

class _CalendarControllerHookState<T> extends HookState<FCalendarController<T>, _CalendarControllerHook<T>> {
  late final FCalendarController<T> _controller;

  @override
  void initHook() {
    _controller = hook._create(hook);
  }

  @override
  FCalendarController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
