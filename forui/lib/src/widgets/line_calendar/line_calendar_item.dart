import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/util.dart';

@internal
class Item extends StatelessWidget {
  final FCalendarController<DateTime?> controller;
  final FLineCalendarItemStyle style;
  final double width;
  final DateTime date;
  final bool today;

  const Item({
    required this.controller,
    required this.style,
    required this.width,
    required this.date,
    required this.today,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, selected, _) => FTappable.animated(
          semanticLabel: FLocalizations.of(context).fullDate(date),
          onPress: () => controller.select(date),
          builder: (context, state, _) => ItemContent(
            style: style,
            stateStyle: switch ((selected == date, state.hovered)) {
              (true, true) => style.selectedHoveredItemStyle,
              (true, false) => style.selectedItemStyle,
              (false, true) => style.unselectedHoveredItemStyle,
              (false, false) => style.unselectedItemStyle,
            },
            width: width,
            date: date,
            today: today,
            hovered: state.hovered,
            focused: state.focused,
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('today', value: today, ifTrue: 'today'));
  }
}

@internal
class ItemContent extends StatelessWidget {
  final FLineCalendarItemStyle style;
  final FLineCalendarItemStateStyle stateStyle;
  final double width;
  final DateTime date;
  final bool today;
  final bool hovered;
  final bool focused;

  const ItemContent({
    required this.style,
    required this.stateStyle,
    required this.width,
    required this.date,
    required this.today,
    required this.hovered,
    required this.focused,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context);
    return DecoratedBox(
      decoration: focused ? stateStyle.focusedDecoration : stateStyle.decoration,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: style.contentSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
              merge(
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                style: today
                    ? stateStyle.dateTextStyle.copyWith(decoration: TextDecoration.underline)
                    : stateStyle.dateTextStyle,
                child: Text(localizations.day(date)),
              ),
              SizedBox(height: style.dateSpacing),
              // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
              merge(
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                style: stateStyle.weekdayTextStyle,
                // TODO: localization
                child: Text(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1]),
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
      ..add(DiagnosticsProperty('stateStyle', stateStyle))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('today', value: today, ifTrue: 'today'))
      ..add(FlagProperty('hovered', value: hovered, ifTrue: 'hovered'))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

/// A line calendar's content style.
final class FLineCalendarItemStyle with Diagnosticable {
  /// The vertical height between the content and the edges. Defaults to 15.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `contentPadding` is negative.
  final double contentSpacing;

  /// The vertical height between the date and weekday. Defaults to 20.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `datePadding` is negative.
  final double dateSpacing;

  /// The selected item's style.
  final FLineCalendarItemStateStyle selectedItemStyle;

  /// The selected item's hovered style.
  final FLineCalendarItemStateStyle selectedHoveredItemStyle;

  /// The unselected item's style.
  final FLineCalendarItemStateStyle unselectedItemStyle;

  /// The unselected item's hovered style.
  final FLineCalendarItemStateStyle unselectedHoveredItemStyle;

  /// Creates a [FLineCalendarItemStyle].
  const FLineCalendarItemStyle({
    required this.selectedItemStyle,
    required this.selectedHoveredItemStyle,
    required this.unselectedItemStyle,
    required this.unselectedHoveredItemStyle,
    this.contentSpacing = 15.5,
    this.dateSpacing = 2,
  })  : assert(0 <= contentSpacing, 'contentSpacing must be non-negative, but is $contentSpacing.'),
        assert(0 <= dateSpacing, 'dateSpacing must be non-negative, but is $dateSpacing.');

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  factory FLineCalendarItemStyle.inherit({
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

    return FLineCalendarItemStyle(
      selectedItemStyle: FLineCalendarItemStateStyle(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: BoxDecoration(
          color: colorScheme.primary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        dateTextStyle: selectedDateTextStyle,
        weekdayTextStyle: selectedWeekdayTextStyle,
      ),
      selectedHoveredItemStyle: FLineCalendarItemStateStyle(
        decoration: BoxDecoration(
          color: colorScheme.hover(colorScheme.primary),
          borderRadius: style.borderRadius,
        ),
        focusedDecoration: BoxDecoration(
          color: colorScheme.hover(colorScheme.primary),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        dateTextStyle: selectedDateTextStyle,
        weekdayTextStyle: selectedWeekdayTextStyle,
      ),
      unselectedItemStyle: FLineCalendarItemStateStyle(
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
        dateTextStyle: unselectedDateTextStyle,
        weekdayTextStyle: unselectedWeekdayTextStyle,
      ),
      unselectedHoveredItemStyle: FLineCalendarItemStateStyle(
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
        dateTextStyle: unselectedDateTextStyle,
        weekdayTextStyle: unselectedWeekdayTextStyle,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('contentPadding', contentSpacing))
      ..add(DoubleProperty('datePadding', dateSpacing))
      ..add(DiagnosticsProperty('selectedItemStyle', selectedItemStyle))
      ..add(DiagnosticsProperty('selectedHoveredItemStyle', selectedHoveredItemStyle))
      ..add(DiagnosticsProperty('unselectedItemStyle', unselectedItemStyle))
      ..add(DiagnosticsProperty('unselectedHoveredItemStyle', unselectedHoveredItemStyle));
  }

  /// Returns a copy of this [FLineCalendarItemStyle] with the given properties replaced.
  @useResult
  FLineCalendarItemStyle copyWith({
    double? contentSpacing,
    double? dateSpacing,
    FLineCalendarItemStateStyle? selectedItemStyle,
    FLineCalendarItemStateStyle? selectedHoveredItemStyle,
    FLineCalendarItemStateStyle? unselectedItemStyle,
    FLineCalendarItemStateStyle? unselectedHoveredItemStyle,
  }) =>
      FLineCalendarItemStyle(
        contentSpacing: contentSpacing ?? this.contentSpacing,
        dateSpacing: dateSpacing ?? this.dateSpacing,
        selectedItemStyle: selectedItemStyle ?? this.selectedItemStyle,
        selectedHoveredItemStyle: selectedHoveredItemStyle ?? this.selectedHoveredItemStyle,
        unselectedItemStyle: unselectedItemStyle ?? this.unselectedItemStyle,
        unselectedHoveredItemStyle: unselectedHoveredItemStyle ?? this.unselectedHoveredItemStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarItemStyle &&
          runtimeType == other.runtimeType &&
          contentSpacing == other.contentSpacing &&
          dateSpacing == other.dateSpacing &&
          selectedItemStyle == other.selectedItemStyle &&
          selectedHoveredItemStyle == other.selectedHoveredItemStyle &&
          unselectedItemStyle == other.unselectedItemStyle &&
          unselectedHoveredItemStyle == other.unselectedHoveredItemStyle;

  @override
  int get hashCode =>
      contentSpacing.hashCode ^
      dateSpacing.hashCode ^
      selectedItemStyle.hashCode ^
      selectedHoveredItemStyle.hashCode ^
      unselectedItemStyle.hashCode ^
      unselectedHoveredItemStyle.hashCode;
}

/// A line calendar item's state style.
final class FLineCalendarItemStateStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The focused decoration.
  final BoxDecoration focusedDecoration;

  /// The text style for the date.
  final TextStyle dateTextStyle;

  /// The text style for the day of the week.
  final TextStyle weekdayTextStyle;

  /// Creates a [FLineCalendarItemStateStyle].
  const FLineCalendarItemStateStyle({
    required this.decoration,
    required this.focusedDecoration,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
  });

  /// Returns a [FLineCalendarItemStateStyle] with the given properties replaced.
  FLineCalendarItemStateStyle copyWith({
    BoxDecoration? decoration,
    BoxDecoration? focusedDecoration,
    TextStyle? dateTextStyle,
    TextStyle? weekdayTextStyle,
  }) =>
      FLineCalendarItemStateStyle(
        decoration: decoration ?? this.decoration,
        focusedDecoration: focusedDecoration ?? this.focusedDecoration,
        dateTextStyle: dateTextStyle ?? this.dateTextStyle,
        weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('focusedDecoration', focusedDecoration))
      ..add(DiagnosticsProperty('dateTextStyle', dateTextStyle))
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarItemStateStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          focusedDecoration == other.focusedDecoration &&
          dateTextStyle == other.dateTextStyle &&
          weekdayTextStyle == other.weekdayTextStyle;

  @override
  int get hashCode =>
      decoration.hashCode ^ focusedDecoration.hashCode ^ dateTextStyle.hashCode ^ weekdayTextStyle.hashCode;
}
