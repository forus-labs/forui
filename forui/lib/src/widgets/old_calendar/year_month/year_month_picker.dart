part of '../calendar.dart';

/// The number of columns in a year & month picker.
@internal
const yearMonthPickerColumns = 3;

/// The number of rows in a year & month picker.
@internal
const yearMonthPickerRows = 4;

/// The total number of items in a year & month picker.
@internal
const yearMonthPickerItems = yearMonthPickerColumns * yearMonthPickerRows;

class YearMonthPicker extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final ValueChanged<LocalDate> onMonthChange;

  const YearMonthPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.onMonthChange,
    super.key,
  });

  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  LocalDate? _date;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_date == null) {
      return PagedYearPicker(
        onPress: (year) => setState(() {
          _date = year;
        }),
        style: widget.style,
        start: widget.start,
        end: widget.end,
        today: widget.today,
        initial: widget.today.truncate(to: DateUnit.years),
      );
    } else {
      return PagedMonthPicker(
        onPress: widget.onMonthChange,
        style: widget.style,
        start: widget.start,
        end: widget.end,
        today: widget.today,
        initial: _date!,
      );
    }
  }
}

final class FCalendarYearMonthPickerStyle with Diagnosticable {
  final FCalendarYearMonthPickerStateStyle enabledStyle;
  final FCalendarYearMonthPickerStateStyle disabledStyle;

  FCalendarYearMonthPickerStyle({required this.enabledStyle, required this.disabledStyle});

  FCalendarYearMonthPickerStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          enabledStyle: FCalendarYearMonthPickerStateStyle(
            decoration: const BoxDecoration(),
            textStyle: typography.sm.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w500),
            focusedDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.secondary,
            ),
          ),
          disabledStyle: FCalendarYearMonthPickerStateStyle(
            decoration: const BoxDecoration(),
            textStyle: typography.sm
                .copyWith(color: colorScheme.mutedForeground.withOpacity(0.5), fontWeight: FontWeight.w500),
          ),
        );
}
