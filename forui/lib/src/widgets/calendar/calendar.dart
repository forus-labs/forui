import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/day/paged_day_picker.dart';
import 'package:forui/src/widgets/calendar/shared/header.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';
import 'package:sugar/sugar.dart';

class FCalendar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class _Calendar extends StatelessWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final ValueNotifier<FCalendarPickerType> type;
  final ValueNotifier<LocalDate> month;
  final Predicate<LocalDate> enabled;
  final Predicate<LocalDate> selected;
  final ValueChanged<LocalDate> onMonthChange;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  const _Calendar({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.type,
    required this.month,
    required this.enabled,
    required this.selected,
    required this.onMonthChange,
    required this.onPress,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: style.decoration,
        child: Padding(
          padding: style.padding,
          child: SizedBox(
            height: (DayPicker.maxRows * DayPicker.tileDimension) + Header.height + 5,
            width: DateTime.daysPerWeek * DayPicker.tileDimension,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ValueListenableBuilder(
                  valueListenable: month,
                  builder: (context, month, child) => Header(
                    style: style.headerStyle,
                    type: type,
                    month: month,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: type,
                  builder: (context, value, child) => switch (value) {
                    FCalendarPickerType.day => PagedDayPicker(
                        style: style,
                        start: start,
                        end: end,
                        today: today,
                        initial: month.value.truncate(to: DateUnit.months),
                        enabled: enabled,
                        selected: selected,
                        onMonthChange: (date) {
                          month.value = date;
                          onMonthChange(date);
                        },
                        onPress: onPress,
                        onLongPress: onLongPress,
                      ),
                    FCalendarPickerType.yearMonth => YearMonthPicker(
                        style: style,
                        start: start,
                        end: end,
                        today: today,
                        onChange: (date) {
                          month.value = date;
                          type.value = FCalendarPickerType.day;
                        },
                      ),
                  },
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('onMonthChange', onMonthChange))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

/// The calendar's style.
final class FCalendarStyle with Diagnosticable {
  /// The header's style.
  final FCalendarHeaderStyle headerStyle;

  /// The day picker's style.
  final FCalendarDayPickerStyle dayPickerStyle;

  /// The year/month picker's style.
  final FCalendarYearMonthPickerStyle yearMonthPickerStyle;

  /// The decoration surrounding the header & picker.
  final BoxDecoration decoration;

  /// The padding surrounding the header & picker. Defaults to `const EdgeInsets.symmetric(horizontal: 12, vertical: 16)`.
  final EdgeInsets padding;

  /// The duration of the page switch animation. Defaults to 200 milliseconds.
  final Duration pageAnimationDuration;

  /// Creates a new [FCalendarStyle].
  FCalendarStyle({
    required this.headerStyle,
    required this.dayPickerStyle,
    required this.yearMonthPickerStyle,
    required this.decoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    this.pageAnimationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FCalendarStyle] that inherits the color scheme and typography.
  FCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          headerStyle: FCalendarHeaderStyle.inherit(colorScheme: colorScheme, typography: typography),
          dayPickerStyle: FCalendarDayPickerStyle.inherit(colorScheme: colorScheme, typography: typography),
          yearMonthPickerStyle: FCalendarYearMonthPickerStyle.inherit(colorScheme: colorScheme, typography: typography),
          decoration: BoxDecoration(
            borderRadius: style.borderRadius,
            border: Border.all(color: colorScheme.border),
            color: colorScheme.background,
          ),
        );

  /// Returns a copy of this [FCalendarStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FCalendarStyle(
  ///   headerStyle: ...,
  ///   dayPickerStyle: ...,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(dayPickerStyle: ...);
  ///
  /// print(style.headerStyle == copy.headerStyle); // true
  /// print(style.dayPickerStyle == copy.dayPickerStyle); // false
  /// ```
  FCalendarStyle copyWith({
    FCalendarHeaderStyle? headerStyle,
    FCalendarDayPickerStyle? dayPickerStyle,
    FCalendarYearMonthPickerStyle? yearMonthPickerStyle,
    BoxDecoration? decoration,
    EdgeInsets? padding,
    Duration? pageAnimationDuration,
  }) =>
      FCalendarStyle(
        headerStyle: headerStyle ?? this.headerStyle,
        dayPickerStyle: dayPickerStyle ?? this.dayPickerStyle,
        yearMonthPickerStyle: yearMonthPickerStyle ?? this.yearMonthPickerStyle,
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
        pageAnimationDuration: pageAnimationDuration ?? this.pageAnimationDuration,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerStyle', headerStyle))
      ..add(DiagnosticsProperty('dayPickerStyle', dayPickerStyle))
      ..add(DiagnosticsProperty('yearMonthPickerStyle', yearMonthPickerStyle))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('pageAnimationDuration', pageAnimationDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarStyle &&
          runtimeType == other.runtimeType &&
          headerStyle == other.headerStyle &&
          dayPickerStyle == other.dayPickerStyle &&
          yearMonthPickerStyle == other.yearMonthPickerStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          pageAnimationDuration == other.pageAnimationDuration;

  @override
  int get hashCode =>
      headerStyle.hashCode ^
      dayPickerStyle.hashCode ^
      yearMonthPickerStyle.hashCode ^
      decoration.hashCode ^
      padding.hashCode ^
      pageAnimationDuration.hashCode;
}
