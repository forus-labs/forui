import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sugar/sugar.dart';

/// A controller that controls date selection in a calendar.
abstract class FCalendarController<T> extends ValueNotifier<T> {
  /// Creates a [FCalendarController] with the given initial [value].
  FCalendarController(super._value);

  /// Called when the given [date] in a [FCalendarPickerType.day] picker is pressed.
  ///
  /// [date] is always in UTC timezone and truncated to the nearest date.
  void onPress(DateTime date);

  /// Returns true if the given [date] is selected.
  bool contains(DateTime date);
}

/// A date selection controller that allows only a single date to be selected.
///
/// The selected date is always in UTC timezone and truncated to the nearest date.
final class FCalendarSingleValueController extends FCalendarController<DateTime?> {
  /// Creates a [FCalendarSingleValueController] with the given initial [value].
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if the given [value] is not in UTC timezone.
  FCalendarSingleValueController([super.value]) : assert(value?.isUtc ?? true, 'value must be in UTC timezone');

  @override
  bool contains(DateTime date) => value?.toLocalDate() == date.toLocalDate();

  @override
  void onPress(DateTime date) {
    if (value?.toLocalDate() == date.toLocalDate()) {
      value = null;
    } else {
      value = date;
    }
  }
}

/// A date selection controller that allows multiple dates to be selected.
///
/// The selected dates are always in UTC timezone and truncated to the nearest date.
final class FCalendarMultiValueController extends FCalendarController<Set<DateTime>> {
  /// Creates a [FCalendarMultiValueController] with the given initial [value].
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if the given dates in [value] is not in UTC timezone.
  FCalendarMultiValueController([super.value = const {}]) : assert(value.every((d) => d.isUtc), 'dates must be in UTC timezone');

  @override
  bool contains(DateTime date) => value.contains(date);

  @override
  void onPress(DateTime date) {
    final copy = { ...value };
    value = copy..toggle(date);
  }
}

/// A date selection controller that allows a single range to be selected.
///
/// Both the start and end dates of the range is inclusive. The selected dates are always in UTC timezone and truncated
/// to the nearest date.
final class FCalendarSingleRangeController extends FCalendarController<(DateTime, DateTime)?> {
  /// Creates a [FCalendarSingleRangeController] with the given initial [value].
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if the given [value] is not in UTC timezone.
  FCalendarSingleRangeController([super.value])
      : assert(value == null || (value.$1.isUtc && value.$2.isUtc), 'value must be in UTC timezone');

  @override
  bool contains(DateTime date) {
    if (value case (final first, final last)) {
      final current = date.toLocalDate();
      return first.toLocalDate() <= current && current <= last.toLocalDate();
    }

    return false;
  }

  @override
  void onPress(DateTime date) {
    if (value == null) {
      value = (date, date);
      return;
    }

    final (first, last) = value!;
    final pressed = date.toLocalDate();

    switch ((first.toLocalDate(), last.toLocalDate())) {
      case (final first, final last) when pressed == first || pressed == last:
        value = null;

      case (final first, final last) when pressed < first:
        value = (pressed.toNative(), last.toNative());

      case (final first,  _):
        value = (first.toNative(), pressed.toNative());
    }
  }
}
