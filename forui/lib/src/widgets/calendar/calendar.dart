import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/day/paged_day_picker.dart';
import 'package:forui/src/widgets/calendar/shared/header.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';
import 'package:sugar/sugar.dart';

export 'day/day_picker.dart' show FCalendarDayPickerStyle, FCalendarDayStyle;
export 'shared/entry.dart' show FCalendarEntryStyle;
export 'shared/header.dart' show FCalendarHeaderStyle, FCalendarPickerType;
export 'year_month_picker.dart' show FCalendarYearMonthPickerStyle;

/// A calendar.
///
/// See:
/// * https://forui.dev/docs/calendar for working examples.
/// * [FCalendarDayStyle] for customizing a card's appearance.
class FCalendar extends StatelessWidget {
  static bool _true(DateTime _) => true;

  /// The style. Defaults to [FThemeData.calendarStyle].
  final FCalendarStyle? style;

  /// The start date. It is truncated to the nearest date.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if [end] <= [start]
  final DateTime start;

  /// The end date. It is truncated to the nearest date.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if [end] <= [start]
  final DateTime end;

  /// The current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  final DateTime today;

  /// A predicate that determines if a date can be selected. It may be called more than once for a single date.
  ///
  /// Defaults to returning true for all dates.
  final Predicate<DateTime> enabled;

  /// A predicate that determines if a date is selected. It may be called more than once for a single date.
  final Predicate<DateTime> selected;

  /// A callback for when the displayed month changes.
  final ValueChanged<DateTime>? onMonthChange;

  /// A callback for when a date in a [FCalendarPickerType.day] picker is pressed.
  final ValueChanged<DateTime>? onPress;

  /// A callback for when a date in a [FCalendarPickerType.day] picker is long pressed.
  final ValueChanged<DateTime>? onLongPress;
  final ValueNotifier<FCalendarPickerType> _type;
  final ValueNotifier<LocalDate> _month;

  /// Creates a [FCalendar] with custom date selection.
  ///
  /// [initialDate] defaults to [today]. It is truncated to the nearest date.
  FCalendar.raw({
    required this.start,
    required this.end,
    required this.selected,
    this.style,
    this.enabled = _true,
    this.onMonthChange,
    this.onPress,
    this.onLongPress,
    FCalendarPickerType initialType = FCalendarPickerType.day,
    DateTime? today,
    DateTime? initialDate,
    super.key,
  })  : assert(start.toLocalDate() < end.toLocalDate(), 'end date must be greater than start date'),
        today = today ?? DateTime.now(),
        _type = ValueNotifier(initialType),
        _month = ValueNotifier((initialDate ?? today ?? DateTime.now()).toLocalDate().truncate(to: DateUnit.months));

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.calendarStyle;
    return DecoratedBox(
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
                valueListenable: _month,
                builder: (context, month, child) => Header(
                  style: style.headerStyle,
                  type: _type,
                  month: month,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _type,
                builder: (context, value, child) => switch (value) {
                  FCalendarPickerType.day => PagedDayPicker(
                      style: style,
                      start: start.toLocalDate(),
                      end: end.toLocalDate(),
                      today: today.toLocalDate(),
                      initial: _month.value,
                      enabled: (date) => enabled(date.toNative()),
                      selected: (date) => selected(date.toNative()),
                      onMonthChange: (date) {
                        _month.value = date;
                        onMonthChange?.call(date.toNative());
                      },
                      onPress: (date) => onPress?.call(date.toNative()),
                      onLongPress: (date) => onLongPress?.call(date.toNative()),
                    ),
                  FCalendarPickerType.yearMonth => YearMonthPicker(
                      style: style,
                      start: start.toLocalDate(),
                      end: end.toLocalDate(),
                      today: today.toLocalDate(),
                      onChange: (date) {
                        _month.value = date;
                        _type.value = FCalendarPickerType.day;
                      },
                    ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('type', _type))
      ..add(DiagnosticsProperty('month', _month))
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
