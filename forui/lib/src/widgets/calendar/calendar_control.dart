part of 'calendar_controller.dart';

/// A [FCalendarControl] defines how a [FCalendar] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FCalendarControl<T> with Diagnosticable, _$FCalendarControlMixin<T> {
  static bool _defaultSelectable(DateTime _) => true;

  /// Creates a [FCalendarControl] for single date selection.
  static FCalendarControl<DateTime?> managedDate({
    FCalendarController<DateTime?>? controller,
    DateTime? initial,
    Predicate<DateTime>? selectable,
    bool toggleable = true,
    bool truncateAndStripTimezone = true,
    ValueChanged<DateTime?>? onChange,
  }) => _Date(
    controller: controller,
    initial: initial,
    selectable: selectable,
    toggleable: toggleable,
    truncateAndStripTimezone: truncateAndStripTimezone,
    onChange: onChange,
  );

  /// Creates a [FCalendarControl] for multiple dates selection.
  static FCalendarControl<Set<DateTime>> managedDates({
    FCalendarController<Set<DateTime>>? controller,
    Set<DateTime>? initial,
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
    ValueChanged<Set<DateTime>>? onChange,
  }) => _Dates(
    controller: controller,
    initial: initial,
    selectable: selectable,
    truncateAndStripTimezone: truncateAndStripTimezone,
    onChange: onChange,
  );

  /// Creates a [FCalendarControl] for range selection.
  static FCalendarControl<(DateTime, DateTime)?> managedRange({
    FCalendarController<(DateTime, DateTime)?>? controller,
    (DateTime, DateTime)? initial,
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
    ValueChanged<(DateTime, DateTime)?>? onChange,
  }) => _Range(
    controller: controller,
    initial: initial,
    selectable: selectable,
    truncateAndStripTimezone: truncateAndStripTimezone,
    onChange: onChange,
  );

  /// Creates lifted state control.
  ///
  /// The [selectable] predicate determines if a date can be selected. Defaults to always true if not given.
  /// The [selected] function determines if a date is currently selected.
  /// The [select] callback is invoked when a date is selected.
  static FCalendarControl<Object?> lifted({
    required Predicate<DateTime> selected,
    required ValueChanged<DateTime> select,
    Predicate<DateTime> selectable = _defaultSelectable,
  }) => _Lifted(selected: selected, select: select, selectable: selectable);

  const FCalendarControl._();

  (FCalendarController<T>, bool) _update(
    FCalendarControl<T> old,
    FCalendarController<T> controller,
    VoidCallback callback,
  );
}

/// A [FCalendarManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
abstract class FCalendarManagedControl<T> extends FCalendarControl<T> with _$FCalendarManagedControlMixin<T> {
  /// The controller.
  @override
  final FCalendarController<T>? controller;

  /// The initial value. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final T? initial;

  /// A predicate that determines if a date can be selected. Defaults to always true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [selectable] and [controller] are both provided.
  @override
  final Predicate<DateTime>? selectable;

  /// Whether to truncate and convert all [DateTime]s to dates in UTC timezone. Defaults to true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [truncateAndStripTimezone] is false and [controller] is provided.
  @override
  final bool truncateAndStripTimezone;

  /// Called when the selected value changes.
  @override
  final ValueChanged<T>? onChange;

  /// Creates a [FCalendarControl].
  const FCalendarManagedControl({
    this.controller,
    this.initial,
    this.selectable,
    this.truncateAndStripTimezone = true,
    this.onChange,
  }) : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
       assert(controller == null || selectable == null, 'Cannot provide both controller and selectable.'),
       assert(
         controller == null || truncateAndStripTimezone,
         'Cannot provide both controller and truncateAndStripTimezone.',
       ),
       super._();

  /// Calls [onChange] with the controller's value.
  void handleOnChange(FCalendarController<Object?> controller) => onChange?.call(controller.value as T);
}

class _Date extends FCalendarManagedControl<DateTime?> {
  final bool toggleable;

  const _Date({
    this.toggleable = true,
    super.controller,
    super.initial,
    super.selectable,
    super.truncateAndStripTimezone,
    super.onChange,
  }) : assert(controller == null || toggleable, 'Cannot provide both controller and toggleable.');

  @override
  FCalendarController<DateTime?> createController() =>
      controller ??
      .date(
        initial: initial,
        selectable: selectable,
        toggleable: toggleable,
        truncateAndStripTimezone: truncateAndStripTimezone,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable', ifFalse: 'not toggleable'));
  }
}

class _Dates extends FCalendarManagedControl<Set<DateTime>> {
  const _Dates({super.controller, super.initial, super.selectable, super.truncateAndStripTimezone, super.onChange});

  @override
  FCalendarController<Set<DateTime>> createController() =>
      controller ??
      .dates(initial: initial ?? {}, selectable: selectable, truncateAndStripTimezone: truncateAndStripTimezone);
}

class _Range extends FCalendarManagedControl<(DateTime, DateTime)?> {
  const _Range({super.controller, super.initial, super.selectable, super.truncateAndStripTimezone, super.onChange});

  @override
  FCalendarController<(DateTime, DateTime)?> createController() =>
      controller ??
      .range(initial: initial, selectable: selectable, truncateAndStripTimezone: truncateAndStripTimezone);
}

class _Lifted extends FCalendarControl<Object?> with _$_LiftedMixin<Object?> {
  @override
  final Predicate<DateTime> selectable;
  @override
  final Predicate<DateTime> selected;
  @override
  final ValueChanged<DateTime> select;

  const _Lifted({required this.selectable, required this.selected, required this.select}) : super._();

  @override
  FCalendarController<Object?> createController() =>
      ProxyController(selectable: selectable, selected: selected, select: select);

  @override
  void _updateController(FCalendarController<Object?> controller) =>
      (controller as ProxyController).update(selectable: selectable, selected: selected, select: select);
}
