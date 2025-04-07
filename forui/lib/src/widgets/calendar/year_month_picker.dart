import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/month/paged_month_picker.dart';
import 'package:forui/src/widgets/calendar/year/paged_year_picker.dart';

part 'year_month_picker.style.dart';

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

/// The year/month picker's style.
final class FCalendarYearMonthPickerStyle with Diagnosticable, _$FCalendarYearMonthPickerStyleFunctions {
  /// The enabled years/months' styles.
  @override
  final FCalendarEntryStyle enabledStyle;

  /// The disabled years/months' styles.
  @override
  final FCalendarEntryStyle disabledStyle;

  /// Creates a new year/month picker style.
  FCalendarYearMonthPickerStyle({required this.enabledStyle, required this.disabledStyle});

  /// Creates a new year/month picker style that inherits the color scheme and typography.
  FCalendarYearMonthPickerStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) : this(
         enabledStyle: FCalendarEntryStyle(
           backgroundColor: colors.background,
           textStyle: typography.base.copyWith(color: colors.foreground, fontWeight: FontWeight.w500),
           hoveredBackgroundColor: colors.secondary,
           focusedBorderColor: colors.foreground,
           radius: const Radius.circular(8),
           tappableStyle: style.tappableStyle.copyWith(animationTween: FTappableAnimations.none),
         ),
         disabledStyle: FCalendarEntryStyle(
           backgroundColor: colors.background,
           textStyle: typography.base.copyWith(
             color: colors.disable(colors.mutedForeground),
             fontWeight: FontWeight.w500,
           ),
           focusedBorderColor: colors.background,
           radius: const Radius.circular(8),
           tappableStyle: style.tappableStyle.copyWith(animationTween: FTappableAnimations.none),
         ),
       );
}
