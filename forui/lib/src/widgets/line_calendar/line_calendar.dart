import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar/calendar_layout.dart';

part 'line_calendar.style.dart';

/// A line calendar displays dates in a single horizontal, scrollable line.
///
/// ## Desktop and web note
/// As the dates scrolls on the horizontal axis (left to right or right to left), hold Shift while using the mouse
/// scroll wheel to scroll the list.
///
/// See:
/// * https://forui.dev/docs/data/line-calendar for working examples.
/// * [FLineCalendarStyle] for customizing a line calendar's style.
class FLineCalendar extends StatelessWidget {
  static Widget _builder(BuildContext _, FLineCalendarItemData _, Widget? child) => child!;

  /// The controller.
  final FCalendarController<DateTime?> controller;

  /// The style.
  final FLineCalendarStyle? style;

  /// The alignment to which the initial date will be aligned. Defaults to [Alignment.center].
  final AlignmentDirectional initialDateAlignment;

  /// {@macro forui.foundation.doc_templates.cacheExtent}
  final double? cacheExtent;

  /// The builder used to build a line calendar item. Defaults to returning the given child.
  ///
  /// The `child` is the default content with no alterations. Consider wrapping the `child` and other custom decoration
  /// in a [Stack] to avoid re-creating the custom content from scratch.
  final ValueWidgetBuilder<FLineCalendarItemData> builder;

  final LocalDate _start;
  final LocalDate? _end;
  final LocalDate? _initial;
  final LocalDate _today;

  /// Creates a [FLineCalendar].
  ///
  /// [start] represents the start date, inclusive. It is truncated to the nearest date. Defaults to the
  /// [DateTime.utc(1900)].
  ///
  /// [end] represents the end date, exclusive. It is truncated to the nearest date.
  ///
  /// [initial] represents the initial date that will appear on the left-most edge on LTR locales. It is truncated to
  /// the nearest date.
  ///
  /// [today] represents the current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [end] <= [start].
  /// * [initial] < [start] or [end] <= [initial].
  /// * [today] < [start] or [end] <= [today].
  FLineCalendar({
    required this.controller,
    this.style,
    this.initialDateAlignment = AlignmentDirectional.center,
    this.cacheExtent,
    this.builder = _builder,
    DateTime? start,
    DateTime? end,
    DateTime? initial,
    DateTime? today,
    super.key,
  }) : _start = (start ?? DateTime.utc(1900)).toLocalDate(),
       _end = end?.toLocalDate(),
       _initial = initial?.toLocalDate(),
       _today = (today ?? DateTime.now()).toLocalDate(),
       assert(
         start == null || end == null || start.toLocalDate() < end.toLocalDate(),
         'end date must be greater than start date',
       ),
       assert(
         initial == null ||
             start == null ||
             (initial.toLocalDate() >= start.toLocalDate() && initial.toLocalDate() < end!.toLocalDate()),
         'initial date must be greater than or equal to start date',
       ),
       assert(
         today == null ||
             start == null ||
             (today.toLocalDate() >= start.toLocalDate() && today.toLocalDate() < end!.toLocalDate()),
         'initial date must be greater than or equal to start date',
       );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder:
        (context, constraints) => CalendarLayout(
          controller: controller,
          style: style ?? context.theme.lineCalendarStyle,
          cacheExtent: cacheExtent,
          scale: MediaQuery.textScalerOf(context),
          textStyle: DefaultTextStyle.of(context).style,
          builder: builder,
          start: _start,
          end: _end,
          initial: _initial,
          today: _today,
          constraints: constraints,
          alignment: initialDateAlignment,
        ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('initialDateAlignment', initialDateAlignment))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// [FLineCalendar]'s style.
final class FLineCalendarStyle with Diagnosticable, _$FLineCalendarStyleFunctions {
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  @override
  final EdgeInsetsGeometry itemPadding;

  /// The vertical height between the content and the edges. Defaults to 15.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `contentPadding` is negative.
  @override
  final double itemContentEdgeSpacing;

  /// The vertical height between the date and weekday. Defaults to 2.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `datePadding` is negative.
  @override
  final double itemContentSpacing;

  /// The selected item's style.
  @override
  final FLineCalendarItemStyle selectedItemStyle;

  /// The selected item's hovered style.
  @override
  final FLineCalendarItemStyle selectedHoveredItemStyle;

  /// The unselected item's style.
  @override
  final FLineCalendarItemStyle unselectedItemStyle;

  /// The unselected item's hovered style.
  @override
  final FLineCalendarItemStyle unselectedHoveredItemStyle;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.selectedItemStyle,
    required this.selectedHoveredItemStyle,
    required this.unselectedItemStyle,
    required this.unselectedHoveredItemStyle,
    required this.tappableStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 6.5),
    this.itemContentEdgeSpacing = 15.5,
    this.itemContentSpacing = 2,
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties.
  factory FLineCalendarStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final focused = BoxDecoration(
      border: Border.all(color: colors.primary, width: style.borderWidth),
      borderRadius: style.borderRadius,
    );

    final selectedDate = typography.xl.copyWith(
      color: colors.primaryForeground,
      fontWeight: FontWeight.w500,
      height: 0,
    );
    final selectedWeekday = typography.xs.copyWith(
      color: colors.primaryForeground,
      fontWeight: FontWeight.w500,
      height: 0,
    );

    final date = typography.xl.copyWith(color: colors.primary, fontWeight: FontWeight.w500, height: 0);
    final weekday = typography.xs.copyWith(color: colors.mutedForeground, fontWeight: FontWeight.w500, height: 0);

    return FLineCalendarStyle(
      selectedItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(color: colors.primary, borderRadius: style.borderRadius),
        focusedDecoration: focused.copyWith(color: colors.primary),
        todayIndicatorColor: colors.primaryForeground,
        dateTextStyle: selectedDate,
        weekdayTextStyle: selectedWeekday,
      ),
      selectedHoveredItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(color: colors.hover(colors.primary), borderRadius: style.borderRadius),
        focusedDecoration: focused.copyWith(color: colors.hover(colors.primary)),
        todayIndicatorColor: colors.hover(colors.primaryForeground),
        dateTextStyle: selectedDate,
        weekdayTextStyle: selectedWeekday,
      ),
      unselectedItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(
          color: colors.background,
          border: Border.all(color: colors.border),
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: focused.copyWith(color: colors.background),
        todayIndicatorColor: colors.primary,
        dateTextStyle: date,
        weekdayTextStyle: weekday,
      ),
      unselectedHoveredItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(
          color: colors.secondary,
          border: Border.all(color: colors.border),
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: focused.copyWith(color: colors.secondary),
        todayIndicatorColor: colors.hover(colors.primary),
        dateTextStyle: date,
        weekdayTextStyle: weekday,
      ),
      tappableStyle: style.tappableStyle,
    );
  }
}
