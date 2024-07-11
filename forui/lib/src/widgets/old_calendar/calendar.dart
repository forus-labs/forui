import 'dart:collection';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

part 'day/day.dart';
part 'day/day_picker.dart';
part 'day/paged_day_picker.dart';

part 'year_month/year_month.dart';
part 'year_month/year_month_picker.dart';
part 'year_month/month/month_picker.dart';
part 'year_month/month/paged_month_picker.dart';
part 'year_month/year/paged_year_picker.dart';
part 'year_month/year/year_picker.dart';

part 'controls.dart';
part 'paged_picker.dart';
part 'toggle.dart';

enum FCalendarPickerMode {
  day,
  yearMonth,
}

@internal
class Calendar extends StatefulWidget {
  final FCalendarStyle style; // TODO: Make this nullable.
  final FCalendarPickerMode initialMode;
  final LocalDate start;
  final LocalDate end;
  final LocalDate today;
  final LocalDate initialMonth;
  final bool Function(LocalDate day) enabledPredicate;
  final bool Function(LocalDate day) selectedPredicate;
  final ValueChanged<DateTime>? onMonthChange;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  const Calendar({
    required this.style,
    required this.start,
    required this.end,
    required this.today,
    required this.initialMonth,
    required this.enabledPredicate,
    required this.selectedPredicate,
    this.onMonthChange,
    required this.onPress,
    required this.onLongPress,
    this.initialMode = FCalendarPickerMode.day,
    super.key,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  late ValueNotifier<FCalendarPickerMode> mode;
  late LocalDate month;
  late AnimationController _yearMonthPickerController;

  @override
  void initState() {
    super.initState();
    mode = ValueNotifier(widget.initialMode);
    month = widget.initialMonth;
    _yearMonthPickerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: widget.style.decoration,
        child: Padding(
          padding: widget.style.padding,
          child: SizedBox(
            height: (maxDayPickerTileDimension * maxDayPickerGridRows) + toggleHeight + 5,
            width: maxDayPickerTileDimension * DateTime.daysPerWeek,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ValueListenableBuilder(
                  valueListenable: mode,
                  builder: (context, value, child) => switch (value) {
                    FCalendarPickerMode.day => PagedDayPicker(
                        style: widget.style,
                        start: widget.start,
                        end: widget.end,
                        today: widget.today,
                        initial: month.truncate(to: DateUnit.months),
                        enabledPredicate: widget.enabledPredicate,
                        selectedPredicate: widget.selectedPredicate,
                        onMonthChange: (month) {
                          print('called');
                          setState(() {
                            this.month = month.toLocalDate();
                          });
                          widget.onMonthChange?.call(month);
                        },
                        onPress: widget.onPress,
                        onLongPress: widget.onLongPress,
                      ),
                    FCalendarPickerMode.yearMonth => YearMonthPicker(
                      style: widget.style,
                      start: widget.start,
                      end: widget.end,
                      today: widget.today,
                      onMonthChange: (date) => setState(() {
                        mode.value = FCalendarPickerMode.day;
                        month = date;
                      }),
                    ),
                  },
                ),
                Toggle(
                  style: widget.style,
                  month: month,
                  mode: mode,
                  yearMonthPickerController: _yearMonthPickerController,
                ),
              ],
            ),
          ),
        ),
      );
}

final class FCalendarStyle with Diagnosticable {
  final FCalendarHeaderStyle headerStyle;
  final FCalendarDayPickerStyle dayPickerStyle;
  final FCalendarYearMonthPickerStyle yearMonthPickerStyle;
  final BoxDecoration decoration;
  final EdgeInsets padding;
  final Duration pageAnimationDuration;

  FCalendarStyle({
    required this.headerStyle,
    required this.dayPickerStyle,
    required this.yearMonthPickerStyle,
    required this.decoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    this.pageAnimationDuration = const Duration(milliseconds: 200),
  });

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
            border: Border.all(
              color: colorScheme.border,
            ),
            color: colorScheme.background,
          ),
        );
}
