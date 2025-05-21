import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

String? _defaultValidator(DateTime? _) => null;

/// Creates a [FDateFieldController] that allows date selection through a calendar and/or input field and is
/// automatically disposed.
///
/// [validator] returns an error string to display if the input is invalid, or null otherwise.
/// It is also used to determine whether a date in a calendar is selectable.
/// Defaults to always returning null.
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
/// Throws [AssertionError] if [initialDate] is not in UTC timezone and [truncateAndStripTimezone] is false.
FDateFieldController useFDateFieldController({
  TickerProvider? vsync,
  DateTime? initialDate,
  FormFieldValidator<DateTime> validator = _defaultValidator,
  bool truncateAndStripTimezone = true,
  Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  List<Object?>? keys,
}) => use(
  _DateFieldHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    initialDate: initialDate,
    validator: validator,
    truncateAndStripTimezone: truncateAndStripTimezone,
    popoverAnimationDuration: popoverAnimationDuration,
    debugLabel: 'useFDatePickerController',
    keys: keys,
  ),
);

class _DateFieldHook extends Hook<FDateFieldController> {
  final TickerProvider vsync;
  final DateTime? initialDate;
  final FormFieldValidator<DateTime> validator;
  final bool truncateAndStripTimezone;
  final Duration popoverAnimationDuration;
  final String _debugLabel;

  const _DateFieldHook({
    required this.vsync,
    required this.initialDate,
    required this.validator,
    required this.truncateAndStripTimezone,
    required this.popoverAnimationDuration,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _DateFieldHookState createState() => _DateFieldHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('initialDate', initialDate))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(
        FlagProperty(
          'truncateAndStripTimezone',
          value: truncateAndStripTimezone,
          ifTrue: 'truncateAndStripTimezone',
        ),
      )
      ..add(
        DiagnosticsProperty(
          'popoverAnimationDuration',
          popoverAnimationDuration,
        ),
      );
  }
}

class _DateFieldHookState
    extends HookState<FDateFieldController, _DateFieldHook> {
  late final FDateFieldController _controller = FDateFieldController(
    vsync: hook.vsync,
    initialDate: hook.initialDate,
    validator: hook.validator,
    truncateAndStripTimezone: hook.truncateAndStripTimezone,
    popoverAnimationDuration: hook.popoverAnimationDuration,
  );

  @override
  FDateFieldController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
