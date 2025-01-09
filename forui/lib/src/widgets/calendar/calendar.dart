import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/day/paged_day_picker.dart';
import 'package:forui/src/widgets/calendar/shared/header.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

/// A calendar's properties.
abstract class FCalendarProperties {}

/// A calendar.
///
/// The calendar pages are designed to be navigable through swipe gestures on mobile Android, iOS & iPadOS, allowing
/// left and right swipes to transition between pages.
///
/// All [DateTime]s are in UTC timezone. A [FCalendarController] is used to customize the date selection behavior.
/// [DateTime]s outside [start] and [end] are unselectable regardless of the [FCalendarController] used.
///
/// See:
/// * https://forui.dev/docs/form/calendar for working examples.
/// * [FCalendarController] for customizing a calendar's date selection behavior.
/// * [FCalendarStyle] for customizing a calendar's appearance.
class FCalendar extends StatelessWidget {
  static Widget _dayBuilder(BuildContext context, FCalendarDayData data, Widget? child) => child!;

  /// The style. Defaults to [FThemeData.calendarStyle].
  final FCalendarStyle? style;

  /// A controller that determines if a date is selected.
  final FCalendarController controller;

  /// The builder used to build a day in the day picker. Defaults to returning the given child.
  ///
  /// The `child` is the default content with no alterations. Consider wrapping the `child` and other custom decoration
  /// in a [Stack] to avoid re-creating the custom day content from scratch.
  final ValueWidgetBuilder<FCalendarDayData> dayBuilder;

  /// The start date, inclusive. It is truncated to the nearest date. Defaults to 1st January, 1900.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [end] <= [start].
  final DateTime start;

  /// The end date, exclusive. It is truncated to the nearest date. Defaults to 1st January, 2100.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [end] <= [start].
  final DateTime end;

  /// The current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  final DateTime today;

  /// A callback for when the displayed month changes.
  final ValueChanged<DateTime>? onMonthChange;

  /// A callback for when a date in a [FCalendarPickerType.day] picker is pressed.
  final ValueChanged<DateTime>? onPress;

  /// A callback for when a date in a [FCalendarPickerType.day] picker is long pressed.
  final ValueChanged<DateTime>? onLongPress;

  final ValueNotifier<FCalendarPickerType> _type;
  final ValueNotifier<LocalDate> _month;

  /// Creates a [FCalendar].
  ///
  /// [initialMonth] defaults to [today]. It is truncated to the nearest date.
  FCalendar({
    required this.controller,
    this.style,
    this.dayBuilder = _dayBuilder,
    this.onMonthChange,
    this.onPress,
    this.onLongPress,
    FCalendarPickerType initialType = FCalendarPickerType.day,
    DateTime? start,
    DateTime? end,
    DateTime? today,
    DateTime? initialMonth,
    super.key,
  })  : start = start ?? DateTime(1990),
        end = end ?? DateTime(2100),
        today = today ?? DateTime.now(),
        _type = ValueNotifier(initialType),
        _month = ValueNotifier((initialMonth ?? today ?? DateTime.now()).toLocalDate().truncate(to: DateUnit.months)) {
    assert(this.start.toLocalDate() < this.end.toLocalDate(), 'end date must be greater than start date');
  }

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.calendarStyle;
    return DecoratedBox(
      decoration: style.decoration,
      child: Padding(
        padding: style.padding,
        child: SizedBox(
          height: (DayPicker.maxRows * style.dayPickerStyle.tileSize) + Header.height + 5,
          width: DateTime.daysPerWeek * style.dayPickerStyle.tileSize,
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
                      dayBuilder: dayBuilder,
                      start: start.toLocalDate(),
                      end: end.toLocalDate(),
                      today: today.toLocalDate(),
                      initial: _month.value,
                      selectable: (date) => controller.selectable(date.toNative()),
                      selected: (date) => controller.selected(date.toNative()),
                      onMonthChange: (date) {
                        _month.value = date;
                        onMonthChange?.call(date.toNative());
                      },
                      onPress: (date) {
                        final native = date.toNative();
                        controller.select(native);
                        onPress?.call(native);
                      },
                      onLongPress: (date) => onLongPress?.call(date.toNative()),
                    ),
                  FCalendarPickerType.yearMonth => YearMonthPicker(
                      style: style,
                      start: start.toLocalDate(),
                      end: end.toLocalDate(),
                      today: today.toLocalDate(),
                      month: _month,
                      type: _type,
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
      ..add(DiagnosticsProperty('controller', controller))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(ObjectFlagProperty.has('onMonthChange', onMonthChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
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

  /// The padding surrounding the header & picker. Defaults to `EdgeInsets.symmetric(horizontal: 12, vertical: 16)`.
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
          headerStyle: FCalendarHeaderStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
          dayPickerStyle: FCalendarDayPickerStyle.inherit(colorScheme: colorScheme, typography: typography),
          yearMonthPickerStyle: FCalendarYearMonthPickerStyle.inherit(colorScheme: colorScheme, typography: typography),
          decoration: BoxDecoration(
            borderRadius: style.borderRadius,
            border: Border.all(color: colorScheme.border),
            color: colorScheme.background,
          ),
        );

  /// Returns a copy of this [FCalendarStyle] but with the given fields replaced with the new values.
  @useResult
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
