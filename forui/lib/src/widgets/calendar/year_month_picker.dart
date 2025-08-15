import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/month/paged_month_picker.dart';
import 'package:forui/src/widgets/calendar/year/paged_year_picker.dart';

@internal
class YearMonthPicker extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final ValueNotifier<LocalDate> month;
  final ValueNotifier<FCalendarPickerType> type;

  const YearMonthPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.month,
    required this.type,
    super.key,
  });

  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('type', type));
  }
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  bool _year = true;

  @override
  Widget build(BuildContext _) {
    if (_year) {
      return PagedYearPicker(
        style: widget.style,
        start: widget.start.truncate(to: DateUnit.years),
        end: widget.end.truncate(to: DateUnit.years),
        today: widget.today,
        initial: widget.month.value.truncate(to: DateUnit.years),
        onPress: (date) {
          widget.month.value = switch (widget.month.value.copyWith(year: date.year)) {
            final proposed when proposed < widget.start => widget.start,
            final proposed when widget.end < proposed => widget.end,
            final proposed => proposed,
          };

          setState(() {
            _year = false;
          });
        },
      );
    } else {
      return PagedMonthPicker(
        style: widget.style,
        start: widget.start.truncate(to: DateUnit.months),
        end: widget.end.truncate(to: DateUnit.months),
        today: widget.today,
        initial: widget.month.value.truncate(to: DateUnit.years),
        onPress: (date) {
          widget.month.value = switch (widget.month.value.copyWith(month: date.month)) {
            final proposed when proposed < widget.start => widget.start,
            final proposed when widget.end < proposed => widget.end,
            final proposed => proposed,
          };

          widget.type.value = FCalendarPickerType.day;
        },
      );
    }
  }
}
