import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/shared/paged_picker.dart';

@internal
class PagedDayPicker extends PagedPicker {
  final Predicate<LocalDate> selected;
  final ValueChanged<LocalDate>? onMonthChange;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;
  final ValueWidgetBuilder<FCalendarDayData> dayBuilder;

  PagedDayPicker({
    required this.selected,
    required this.onMonthChange,
    required this.onPress,
    required this.onLongPress,
    required this.dayBuilder,
    required super.style,
    required super.start,
    required super.end,
    required super.today,
    required super.initial,
    required super.selectable,
    super.key,
  });

  @override
  State<PagedDayPicker> createState() => _PagedDayPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('selected', selected))
      ..add(ObjectFlagProperty.has('onMonthChange', onMonthChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder));
  }
}

class _PagedDayPickerState extends PagedPickerState<PagedDayPicker> {
  bool _gridFocused = false;

  @override
  Widget buildItem(BuildContext context, int page) => DayPicker(
    style: widget.style.dayPickerStyle,
    localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
    dayBuilder: widget.dayBuilder,
    month: widget.start.truncate(to: DateUnit.months).plus(months: page),
    today: widget.today,
    focused: focusedDate,
    selectable: widget.selectable,
    selected: widget.selected,
    onPress: (date) {
      setState(() {
        if (_gridFocused) {
          focusedDate = date;
        }
      });
      widget.onPress(date);
    },
    onLongPress: widget.onLongPress,
  );

  @override
  void onPageChange(int page) {
    setState(() {
      final changed = widget.start.truncate(to: DateUnit.months).plus(months: page);
      if (current == changed) {
        return;
      }

      current = changed;
      widget.onMonthChange?.call(current);
      if (focusedDate case final focused? when focused.truncate(to: DateUnit.months) == current) {
        // We have navigated to a new month with the grid focused, but the
        // focused day is not in this month. Choose a new one trying to keep
        // the same day of the month.
        focusedDate = _focusableDayForMonth(current, focusedDate!.day);
      }
      SemanticsService.sendAnnouncement(
        View.of(context),
        (FLocalizations.of(context) ?? FDefaultLocalizations()).fullDate(current.toNative()),
        textDirection,
      );
    });
  }

  @override
  void onGridFocusChange(bool focused) {
    setState(() {
      _gridFocused = focused;
      if (focused && focusedDate == null) {
        final preferred = widget.today.truncate(to: DateUnit.months) == current ? widget.today.day : 1;
        focusedDate = _focusableDayForMonth(current, preferred);
      } else if (!focused) {
        focusedDate = null;
      }
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
      if (widget.selectable(newFocus)) {
        return newFocus;
      }
    }

    // Start at the 1st and take the first enabled date.
    for (var newFocus = month; newFocus.month == month.month; newFocus = newFocus.tomorrow) {
      if (widget.selectable(newFocus)) {
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
