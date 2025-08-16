import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/src/widgets/calendar/month/month_picker.dart';
import 'package:forui/src/widgets/calendar/shared/paged_picker.dart';

@internal
class PagedMonthPicker extends PagedPicker {
  final ValueChanged<LocalDate> onPress;

  PagedMonthPicker({
    required this.onPress,
    required super.style,
    required super.start,
    required super.end,
    required super.today,
    required super.initial,
    super.key,
  });

  @override
  State<PagedMonthPicker> createState() => _PagedMonthPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('onPress', onPress));
  }
}

class _PagedMonthPickerState extends PagedPickerState<PagedMonthPicker> {
  @override
  Widget buildItem(BuildContext context, int page) => MonthPicker(
    yearMonthStyle: widget.style.yearMonthPickerStyle,
    dayStyle: widget.style.dayPickerStyle,
    currentYear: widget.initial,
    start: widget.start,
    end: widget.end,
    today: widget.today,
    focused: focusedDate,
    onPress: widget.onPress,
  );

  @override
  void onPageChange(int page) {} // Months will only appear on a single page.

  @override
  void onGridFocusChange(bool focused) {
    setState(() {
      if (focused && focusedDate == null) {
        final currentMonth = widget.today.truncate(to: DateUnit.months);
        focusedDate = _focusableMonth(widget.initial.year == widget.today.year ? currentMonth : current);
      }
    });
  }

  LocalDate? _focusableMonth(LocalDate preferredMonth) {
    final end = widget.initial.plus(years: 1);
    if (widget.initial <= preferredMonth && preferredMonth < end) {
      return preferredMonth;
    }

    for (var newFocus = widget.initial; newFocus < end; newFocus = newFocus.plus(months: 1)) {
      if (widget.selectable(newFocus)) {
        return newFocus;
      }
    }

    return null;
  }

  @override
  int delta(LocalDate start, LocalDate end) => 0;

  @override
  Map<TraversalDirection, Period> get directionOffset => const {
    TraversalDirection.up: Period(months: -MonthPicker.columns),
    TraversalDirection.right: Period(months: 1),
    TraversalDirection.down: Period(months: MonthPicker.columns),
    TraversalDirection.left: Period(months: -1),
  };
}
