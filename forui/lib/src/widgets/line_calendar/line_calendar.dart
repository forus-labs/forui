import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar/calendar_layout.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

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
  static Widget _builder(BuildContext context, FLineCalendarItemData state, Widget? child) => child!;

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
  })  : _start = (start ?? DateTime.utc(1900)).toLocalDate(),
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
        builder: (context, constraints) => CalendarLayout(
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
final class FLineCalendarStyle with Diagnosticable {
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  final EdgeInsets itemPadding;

  /// The vertical height between the content and the edges. Defaults to 15.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `contentPadding` is negative.
  final double itemContentEdgeSpacing;

  /// The vertical height between the date and weekday. Defaults to 2.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `datePadding` is negative.
  final double itemContentSpacing;

  /// The selected item's style.
  final FLineCalendarItemStyle selectedItemStyle;

  /// The selected item's hovered style.
  final FLineCalendarItemStyle selectedHoveredItemStyle;

  /// The unselected item's style.
  final FLineCalendarItemStyle unselectedItemStyle;

  /// The unselected item's hovered style.
  final FLineCalendarItemStyle unselectedHoveredItemStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.selectedItemStyle,
    required this.selectedHoveredItemStyle,
    required this.unselectedItemStyle,
    required this.unselectedHoveredItemStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 6.5),
    this.itemContentEdgeSpacing = 15.5,
    this.itemContentSpacing = 2,
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties from [colorScheme] and [typography].
  factory FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) {
    final focusedBorder = Border.all(color: colorScheme.primary, width: style.borderWidth);

    final selectedDateTextStyle = typography.xl.copyWith(
      color: colorScheme.primaryForeground,
      fontWeight: FontWeight.w500,
      height: 0,
    );

    final selectedWeekdayTextStyle = typography.xs.copyWith(
      color: colorScheme.primaryForeground,
      fontWeight: FontWeight.w500,
      height: 0,
    );

    final unselectedDateTextStyle = typography.xl.copyWith(
      color: colorScheme.primary,
      fontWeight: FontWeight.w500,
      height: 0,
    );
    final unselectedWeekdayTextStyle = typography.xs.copyWith(
      color: colorScheme.mutedForeground,
      fontWeight: FontWeight.w500,
      height: 0,
    );

    return FLineCalendarStyle(
      selectedItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: BoxDecoration(
          color: colorScheme.primary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        todayIndicatorColor: colorScheme.primaryForeground,
        dateTextStyle: selectedDateTextStyle,
        weekdayTextStyle: selectedWeekdayTextStyle,
      ),
      selectedHoveredItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(
          color: colorScheme.hover(colorScheme.primary),
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: BoxDecoration(
          color: colorScheme.hover(colorScheme.primary),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        todayIndicatorColor: colorScheme.hover(colorScheme.primaryForeground),
        dateTextStyle: selectedDateTextStyle,
        weekdayTextStyle: selectedWeekdayTextStyle,
      ),
      unselectedItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: BoxDecoration(
          color: colorScheme.background,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        todayIndicatorColor: colorScheme.primary,
        dateTextStyle: unselectedDateTextStyle,
        weekdayTextStyle: unselectedWeekdayTextStyle,
      ),
      unselectedHoveredItemStyle: FLineCalendarItemStyle(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: BoxDecoration(
          color: colorScheme.secondary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        todayIndicatorColor: colorScheme.hover(colorScheme.primary),
        dateTextStyle: unselectedDateTextStyle,
        weekdayTextStyle: unselectedWeekdayTextStyle,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DoubleProperty('itemContentEdgeSpacing', itemContentEdgeSpacing))
      ..add(DoubleProperty('itemContentSpacing', itemContentSpacing))
      ..add(DiagnosticsProperty('selectedItemStyle', selectedItemStyle))
      ..add(DiagnosticsProperty('selectedHoveredItemStyle', selectedHoveredItemStyle))
      ..add(DiagnosticsProperty('unselectedItemStyle', unselectedItemStyle))
      ..add(DiagnosticsProperty('unselectedHoveredItemStyle', unselectedHoveredItemStyle));
  }

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsets? itemPadding,
    double? itemContentEdgeSpacing,
    double? itemContentSpacing,
    FLineCalendarItemStyle? selectedItemStyle,
    FLineCalendarItemStyle? selectedHoveredItemStyle,
    FLineCalendarItemStyle? unselectedItemStyle,
    FLineCalendarItemStyle? unselectedHoveredItemStyle,
  }) =>
      FLineCalendarStyle(
        itemPadding: itemPadding ?? this.itemPadding,
        itemContentEdgeSpacing: itemContentEdgeSpacing ?? this.itemContentEdgeSpacing,
        itemContentSpacing: itemContentSpacing ?? this.itemContentSpacing,
        selectedItemStyle: selectedItemStyle ?? this.selectedItemStyle,
        selectedHoveredItemStyle: selectedHoveredItemStyle ?? this.selectedHoveredItemStyle,
        unselectedItemStyle: unselectedItemStyle ?? this.unselectedItemStyle,
        unselectedHoveredItemStyle: unselectedHoveredItemStyle ?? this.unselectedHoveredItemStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarStyle &&
          runtimeType == other.runtimeType &&
          itemPadding == other.itemPadding &&
          itemContentEdgeSpacing == other.itemContentEdgeSpacing &&
          itemContentSpacing == other.itemContentSpacing &&
          selectedItemStyle == other.selectedItemStyle &&
          selectedHoveredItemStyle == other.selectedHoveredItemStyle &&
          unselectedItemStyle == other.unselectedItemStyle &&
          unselectedHoveredItemStyle == other.unselectedHoveredItemStyle;

  @override
  int get hashCode =>
      itemPadding.hashCode ^
      itemContentEdgeSpacing.hashCode ^
      itemContentSpacing.hashCode ^
      selectedItemStyle.hashCode ^
      selectedHoveredItemStyle.hashCode ^
      unselectedItemStyle.hashCode ^
      unselectedHoveredItemStyle.hashCode;
}
