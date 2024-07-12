import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/calendar.dart';
import 'package:forui/src/widgets/calendar/month/paged_month_picker.dart';
import 'package:forui/src/widgets/calendar/shared/entry.dart';
import 'package:forui/src/widgets/calendar/year/paged_year_picker.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

@internal
class YearMonthPicker extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final ValueChanged<LocalDate> onChange;

  const YearMonthPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.onChange,
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
      ..add(DiagnosticsProperty('onChange', onChange));
  }
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
        style: widget.style,
        start: widget.start,
        end: widget.end,
        today: widget.today,
        initial: widget.today.truncate(to: DateUnit.years),
        onPress: (year) => setState(() => _date = year),
      );
    } else {
      return PagedMonthPicker(
        style: widget.style,
        start: widget.start,
        end: widget.end,
        today: widget.today,
        initial: _date!,
        onPress: widget.onChange,
      );
    }
  }
}


/// The year/month picker's style.
final class FCalendarYearMonthPickerStyle with Diagnosticable {
  /// The enabled years/months' styles.
  final FCalendarEntryStyle enabledStyle;
  /// The disabled years/months' styles.
  final FCalendarEntryStyle disabledStyle;

  /// Creates a new year/month picker style.
  FCalendarYearMonthPickerStyle({required this.enabledStyle, required this.disabledStyle});

  /// Creates a new year/month picker style that inherits the color scheme and typography.
  FCalendarYearMonthPickerStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          enabledStyle: FCalendarEntryStyle(
            backgroundColor: colorScheme.background,
            textStyle: typography.sm.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w500),
            focusedBackgroundColor: colorScheme.secondary,
          ),
          disabledStyle: FCalendarEntryStyle(
            backgroundColor: colorScheme.background,
            textStyle: typography.sm
                .copyWith(color: colorScheme.mutedForeground.withOpacity(0.5), fontWeight: FontWeight.w500),
          ),
        );

  /// Returns a copy of this [FCalendarYearMonthPickerStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FCalendarYearMonthPickerStyle(
  ///   enabledStyle: ...,
  ///   disabledStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(disabledStyle: ...);
  ///
  /// print(style.enabledStyle == copy.enabledStyle); // true
  /// print(style.disabledStyle == copy.disabledStyle); // false
  /// ```
  FCalendarYearMonthPickerStyle copyWith({
    FCalendarEntryStyle? enabledStyle,
    FCalendarEntryStyle? disabledStyle,
  }) => FCalendarYearMonthPickerStyle(
    enabledStyle: enabledStyle ?? this.enabledStyle,
    disabledStyle: disabledStyle ?? this.disabledStyle,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FCalendarYearMonthPickerStyle && runtimeType == other.runtimeType &&
              enabledStyle == other.enabledStyle && disabledStyle == other.disabledStyle;

  @override
  int get hashCode => enabledStyle.hashCode ^ disabledStyle.hashCode;
}
