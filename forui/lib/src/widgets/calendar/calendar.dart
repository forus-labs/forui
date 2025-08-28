import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/day/paged_day_picker.dart';
import 'package:forui/src/widgets/calendar/shared/header.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';

part 'calendar.design.dart';

/// A calendar.
///
/// The calendar pages are designed to be navigable through swipe gestures on mobile Android, iOS & iPadOS, allowing
/// left and right swipes to transition between pages.
///
/// All [DateTime]s are in UTC timezone. A [FCalendarController] is used to customize the date selection behavior.
/// [DateTime]s outside [start] and [end] are unselectable regardless of the [FCalendarController] used.
///
/// See:
/// * https://forui.dev/docs/calendar for working examples.
/// * [FCalendarController] for customizing a calendar's date selection behavior.
/// * [FCalendarStyle] for customizing a calendar's appearance.
class FCalendar extends StatefulWidget {
  /// The default day builder.
  static Widget defaultDayBuilder(BuildContext _, FCalendarDayData data, Widget? child) => child!;

  /// The style. Defaults to [FThemeData.calendarStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create calendar
  /// ```
  final FCalendarStyle Function(FCalendarStyle style)? style;

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

  final FCalendarPickerType _initialType;
  final LocalDate _initialMonth;

  /// Creates a [FCalendar].
  ///
  /// Subsequently changing [initialType] has no effect.
  ///
  /// [initialMonth] defaults to [today]. It is truncated to the nearest date. Subsequently changing [initialMonth] has
  /// no effect. To change the selected date, change the key to create a new [FCalendar], and provide that widget the
  /// new [initialMonth]. This will reset the widget's interactive state.
  FCalendar({
    required this.controller,
    this.style,
    this.dayBuilder = defaultDayBuilder,
    this.onMonthChange,
    this.onPress,
    this.onLongPress,
    FCalendarPickerType initialType = FCalendarPickerType.day,
    DateTime? start,
    DateTime? end,
    DateTime? today,
    DateTime? initialMonth,
    super.key,
  }) : start = start ?? DateTime(1900),
       end = end ?? DateTime(2100),
       today = today ?? DateTime.now(),
       _initialType = initialType,
       _initialMonth = (initialMonth ?? today ?? DateTime.now()).toLocalDate().truncate(to: DateUnit.months) {
    assert(this.start.toLocalDate() < this.end.toLocalDate(), 'start ($start) must be < end ($end)');
  }

  @override
  State<FCalendar> createState() => _State();

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

class _State extends State<FCalendar> {
  late ValueNotifier<FCalendarPickerType> _type;
  late ValueNotifier<LocalDate> _month;

  @override
  void initState() {
    super.initState();
    _type = ValueNotifier(widget._initialType);
    _month = ValueNotifier(widget._initialMonth);
  }

  @override
  void dispose() {
    _month.dispose();
    _type.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.calendarStyle) ?? context.theme.calendarStyle;
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
                builder: (_, month, _) => Header(style: style.headerStyle, type: _type, month: month),
              ),
              ValueListenableBuilder(
                valueListenable: _type,
                builder: (_, value, _) => switch (value) {
                  FCalendarPickerType.day => PagedDayPicker(
                    style: style,
                    dayBuilder: widget.dayBuilder,
                    start: widget.start.toLocalDate(),
                    end: widget.end.toLocalDate(),
                    today: widget.today.toLocalDate(),
                    initial: _month.value,
                    selectable: (date) => widget.controller.selectable(date.toNative()),
                    selected: (date) => widget.controller.selected(date.toNative()),
                    onMonthChange: (date) {
                      _month.value = date;
                      widget.onMonthChange?.call(date.toNative());
                    },
                    onPress: (date) {
                      final native = date.toNative();
                      widget.controller.select(native);
                      widget.onPress?.call(native);
                    },
                    onLongPress: (date) => widget.onLongPress?.call(date.toNative()),
                  ),
                  FCalendarPickerType.yearMonth => YearMonthPicker(
                    style: style,
                    start: widget.start.toLocalDate(),
                    end: widget.end.toLocalDate(),
                    today: widget.today.toLocalDate(),
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
}

/// The calendar's style.
class FCalendarStyle with Diagnosticable, _$FCalendarStyleFunctions {
  /// The header's style.
  @override
  final FCalendarHeaderStyle headerStyle;

  /// The day picker's style.
  @override
  final FCalendarDayPickerStyle dayPickerStyle;

  /// The year/month picker's style.
  @override
  final FCalendarEntryStyle yearMonthPickerStyle;

  /// The decoration surrounding the header & picker.
  @override
  final BoxDecoration decoration;

  /// The padding surrounding the header & picker. Defaults to `EdgeInsets.symmetric(horizontal: 12, vertical: 16)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The duration of the page switch animation. Defaults to 200 milliseconds.
  @override
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

  /// Creates a [FCalendarStyle] that inherits its properties.
  FCalendarStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        headerStyle: FCalendarHeaderStyle.inherit(colors: colors, typography: typography, style: style),
        dayPickerStyle: FCalendarDayPickerStyle.inherit(colors: colors, typography: typography),
        yearMonthPickerStyle: FCalendarEntryStyle(
          backgroundColor: FWidgetStateMap({
            (WidgetState.hovered | WidgetState.pressed) & ~WidgetState.disabled: colors.secondary,
            WidgetState.any: colors.background,
          }),
          borderColor: FWidgetStateMap({
            WidgetState.disabled: colors.background,
            WidgetState.focused: colors.foreground,
          }),
          textStyle: FWidgetStateMap({
            WidgetState.disabled: typography.base.copyWith(
              color: colors.disable(colors.mutedForeground),
              fontWeight: FontWeight.w500,
            ),
            WidgetState.any: typography.base.copyWith(color: colors.foreground, fontWeight: FontWeight.w500),
          }),
          radius: const Radius.circular(8),
        ),
        decoration: BoxDecoration(
          borderRadius: style.borderRadius,
          border: Border.all(color: colors.border),
          color: colors.background,
        ),
      );
}
