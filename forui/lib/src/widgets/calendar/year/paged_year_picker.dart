import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/src/widgets/calendar/shared/paged_picker.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';

@internal
class PagedYearPicker extends PagedPicker {
  final ValueChanged<LocalDate> onPress;

  PagedYearPicker({
    required this.onPress,
    required super.style,
    required super.start,
    required super.end,
    required super.today,
    required super.initial,
    super.key,
  });

  @override
  State<PagedYearPicker> createState() => _PagedYearPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('onPress', onPress));
  }
}

class _PagedYearPickerState extends PagedPickerState<PagedYearPicker> {
  @override
  Widget buildItem(BuildContext _, int page) => YearPicker(
    yearMonthStyle: widget.style.yearMonthPickerStyle,
    dayStyle: widget.style.dayPickerStyle,
    startYear: widget.start.truncate(to: DateUnit.years).plus(years: page * YearPicker.items),
    start: widget.start,
    end: widget.end,
    today: widget.today,
    focused: focusedDate,
    onPress: widget.onPress,
  );

  @override
  void onGridFocusChange(bool focused) {
    setState(() {
      if (focused && focusedDate == null) {
        final currentYear = widget.today.truncate(to: DateUnit.years);
        focusedDate = _focusableYear(current, currentYear == current ? currentYear : current);
      }
    });
  }

  @override
  void onPageChange(int page) {
    setState(() {
      final changed = widget.start.truncate(to: DateUnit.years).plus(years: page * YearPicker.items);
      if (current == changed) {
        return;
      }

      current = changed;
      if (focusedDate case final focused? when focused.truncate(to: DateUnit.years) == current) {
        // We have navigated to a new page with the grid focused, but the
        // focused year is not in this page. Choose a new one.
        focusedDate = _focusableYear(current, focusedDate!);
      }

      SemanticsService.sendAnnouncement(View.of(context), current.toString(), textDirection);
    });
  }

  LocalDate? _focusableYear(LocalDate startYear, LocalDate preferredYear) {
    final endYear = startYear.plus(years: YearPicker.items);
    if (startYear <= preferredYear && preferredYear < endYear) {
      return preferredYear;
    }

    for (var newFocus = startYear; newFocus < endYear; newFocus = newFocus.plus(years: 1)) {
      if (widget.selectable(newFocus)) {
        return newFocus;
      }
    }

    return null;
  }

  @override
  int delta(LocalDate start, LocalDate end) => ((end.year - start.year) / YearPicker.items).floor();

  @override
  Map<TraversalDirection, Period> get directionOffset => const {
    TraversalDirection.up: Period(years: -YearPicker.columns),
    TraversalDirection.right: Period(years: 1),
    TraversalDirection.down: Period(years: YearPicker.columns),
    TraversalDirection.left: Period(years: -1),
  };
}
