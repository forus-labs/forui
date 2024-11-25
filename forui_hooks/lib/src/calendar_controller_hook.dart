import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

typedef _Create<T> = FCalendarController<T> Function(_CalendarControllerHook<T>);

/// Creates a [FCalendarController] that allows only a single date to be selected and is automatically disposed.
///
/// [selectable] will always return true if not given.
FCalendarController<DateTime?> useFDateCalendarController({
  DateTime? initialSelection,
  bool Function(DateTime)? selectable,
  List<Object?>? keys,
}) =>
    use(_CalendarControllerHook<DateTime?>(
      value: initialSelection,
      selectable: selectable,
      debugLabel: 'useFDateCalendarController',
      create: (hook) => FCalendarController.date(
        initialSelection: hook.value,
        selectable: hook.selectable,
      ),
    ));

/// Creates a [FCalendarController] that allows only multiple dates to be selected and is automatically disposed.
///
/// [selectable] will always return true if not given.
FCalendarController<Set<DateTime>> useFDatesCalendarController({
  Set<DateTime> initialSelections = const {},
  bool Function(DateTime)? selectable,
  List<Object?>? keys,
}) =>
    use(_CalendarControllerHook<Set<DateTime>>(
      value: initialSelections,
      selectable: selectable,
      debugLabel: 'useFDatesCalendarController',
      create: (hook) => FCalendarController.dates(
        initialSelections: hook.value,
        selectable: hook.selectable,
      ),
    ));

/// Creates a [FCalendarController] that allows a single range to be selected to be selected and is automatically
/// disposed.
///
/// [selectable] will always return true if not given.
///
/// Both the start and end dates of the range is inclusive. The selected dates are always in UTC timezone and truncated
/// to the nearest day. Unselectable dates within the selected range are selected regardless.
FCalendarController<(DateTime, DateTime)?> useFRangeCalendarController({
  (DateTime, DateTime)? initialSelection,
  bool Function(DateTime)? selectable,
  List<Object?>? keys,
}) =>
    use(_CalendarControllerHook<(DateTime, DateTime)?>(
      value: initialSelection,
      selectable: selectable,
      debugLabel: 'useFRangeCalendarController',
      create: (hook) => FCalendarController.range(
        initialSelection: hook.value,
        selectable: hook.selectable,
      ),
    ));

class _CalendarControllerHook<T> extends Hook<FCalendarController<T>> {
  final T value;
  final bool Function(DateTime)? selectable;
  final String _debugLabel;
  final _Create<T> _create;

  const _CalendarControllerHook({
    required this.value,
    required this.selectable,
    required String debugLabel,
    required _Create<T> create,
    super.keys,
  })  : _create = create,
        _debugLabel = debugLabel;

  @override
  _CalendarControllerHookState<T> createState() => _CalendarControllerHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('initialSelection', value))
      ..add(ObjectFlagProperty.has('selectable', selectable));
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
