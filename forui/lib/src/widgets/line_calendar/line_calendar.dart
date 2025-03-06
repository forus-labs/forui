import 'package:collection/collection.dart';
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
        (_, constraints) => CalendarLayout(
          controller: controller,
          style: style,
          cacheExtent: cacheExtent,
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
  final EdgeInsetsGeometry padding;

  /// The vertical height between the content and the edges. Defaults to 15.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if negative.
  @override
  final double contentEdgeSpacing;

  /// The vertical height between the date and weekday. Defaults to 2.
  ///
  /// ## Contract
  /// Throws [AssertionError] if negative.
  @override
  final double contentSpacing;

  /// The decoration.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The color of the today indicator.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> todayIndicatorColor;

  /// The text style for the date.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<TextStyle> dateTextStyle;

  /// The text style for the day of the week.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<TextStyle> weekdayTextStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.decoration,
    required this.todayIndicatorColor,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.5),
    this.contentEdgeSpacing = 15.5,
    this.contentSpacing = 2,
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties from [colorScheme] and [typography].
  factory FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) {
    final focusedBorder = Border.all(color: colorScheme.primary, width: style.borderWidth);
    return FLineCalendarStyle(
      decoration: FWidgetStateMap({
        WidgetState.selected & WidgetState.hovered & WidgetState.focused: BoxDecoration(
          color: colorScheme.hover(colorScheme.primary),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected & WidgetState.hovered: BoxDecoration(
          color: colorScheme.hover(colorScheme.primary),
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected & WidgetState.focused: BoxDecoration(
          color: colorScheme.primary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected: BoxDecoration(color: colorScheme.primary, borderRadius: style.borderRadius),
        WidgetState.hovered & WidgetState.focused: BoxDecoration(
          color: colorScheme.secondary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.hovered: BoxDecoration(
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
        ),
        WidgetState.focused: BoxDecoration(
          color: colorScheme.background,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        ~WidgetState.focused: BoxDecoration(
          color: colorScheme.background,
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
        ),
      }),
      todayIndicatorColor: FWidgetStateMap({
        WidgetState.selected & WidgetState.hovered: colorScheme.hover(colorScheme.primaryForeground),
        WidgetState.selected: colorScheme.primaryForeground,
        WidgetState.hovered: colorScheme.hover(colorScheme.primary),
        ~WidgetState.selected: colorScheme.primary,
      }),
      dateTextStyle: FWidgetStateMap({
        WidgetState.selected: typography.xl.copyWith(
          color: colorScheme.primaryForeground,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
        ~WidgetState.selected: typography.xl.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      }),
      weekdayTextStyle: FWidgetStateMap({
        WidgetState.selected: typography.xs.copyWith(
          color: colorScheme.primaryForeground,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
        ~WidgetState.selected: typography.xs.copyWith(
          color: colorScheme.mutedForeground,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      }),
    );
  }
}
