import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// The state of a line calendar item used to build a line calendar item.
typedef FLineCalendarItemData = ({
  FLineCalendarStyle style,
  FLineCalendarItemStyle itemStyle,
  DateTime date,
  bool today,
  bool selected,
  bool hovered,
  bool focused,
});

@internal
class Item extends StatelessWidget {
  final FCalendarController<DateTime?> controller;
  final FLineCalendarStyle style;
  final DateTime date;
  final bool today;
  final ValueWidgetBuilder<FLineCalendarItemData> builder;

  const Item({
    required this.controller,
    required this.style,
    required this.date,
    required this.today,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, selected, _) => FTappable.animated(
          focusNode: FocusNode(debugLabel: 'Date: $date'),
          semanticLabel: FLocalizations.of(context).fullDate(date),
          onPress: () => controller.select(date),
          builder: (context, state, _) {
            final itemStyle = switch ((selected == date, state.hovered)) {
              (true, true) => style.selectedHoveredItemStyle,
              (true, false) => style.selectedItemStyle,
              (false, true) => style.unselectedHoveredItemStyle,
              (false, false) => style.unselectedItemStyle,
            };

            final itemData = (
              style: style,
              itemStyle: itemStyle,
              date: date,
              today: today,
              selected: selected == date,
              hovered: state.hovered,
              focused: state.focused,
            );

            return builder(
              context,
              itemData,
              Stack(
                children: [
                  Positioned.fill(
                    child: ItemContent(
                      style: style,
                      itemStyle: itemStyle,
                      date: date,
                      hovered: state.hovered,
                      focused: state.focused,
                    ),
                  ),
                  if (today)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          color: itemStyle.todayIndicatorColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('today', value: today, ifTrue: 'today'))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

@internal
class ItemContent extends StatelessWidget {
  final FLineCalendarStyle style;
  final FLineCalendarItemStyle itemStyle;
  final DateTime date;
  final bool hovered;
  final bool focused;

  const ItemContent({
    required this.style,
    required this.itemStyle,
    required this.date,
    required this.hovered,
    required this.focused,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context);
    return DecoratedBox(
      decoration: focused ? itemStyle.focusedDecoration : itemStyle.decoration,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: style.itemContentEdgeSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: itemStyle.dateTextStyle,
              child: Text(localizations.day(date)),
            ),
            SizedBox(height: style.itemContentSpacing),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: itemStyle.weekdayTextStyle,
              child: Text(localizations.shortWeekDays[date.weekday % 7]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('itemStyle', itemStyle))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('hovered', value: hovered, ifTrue: 'hovered'))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

/// A line calendar item's state style.
final class FLineCalendarItemStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The focused decoration.
  final BoxDecoration focusedDecoration;

  /// The color of the today indicator.
  final Color todayIndicatorColor;

  /// The text style for the date.
  final TextStyle dateTextStyle;

  /// The text style for the day of the week.
  final TextStyle weekdayTextStyle;

  /// Creates a [FLineCalendarItemStyle].
  const FLineCalendarItemStyle({
    required this.decoration,
    required this.focusedDecoration,
    required this.todayIndicatorColor,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
  });

  /// Returns a [FLineCalendarItemStyle] with the given properties replaced.
  FLineCalendarItemStyle copyWith({
    BoxDecoration? decoration,
    BoxDecoration? focusedDecoration,
    Color? todayIndicatorColor,
    TextStyle? dateTextStyle,
    TextStyle? weekdayTextStyle,
  }) =>
      FLineCalendarItemStyle(
        decoration: decoration ?? this.decoration,
        focusedDecoration: focusedDecoration ?? this.focusedDecoration,
        todayIndicatorColor: todayIndicatorColor ?? this.todayIndicatorColor,
        dateTextStyle: dateTextStyle ?? this.dateTextStyle,
        weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('focusedDecoration', focusedDecoration))
      ..add(ColorProperty('todayIndicatorColor', todayIndicatorColor))
      ..add(DiagnosticsProperty('dateTextStyle', dateTextStyle))
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarItemStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          focusedDecoration == other.focusedDecoration &&
          todayIndicatorColor == other.todayIndicatorColor &&
          dateTextStyle == other.dateTextStyle &&
          weekdayTextStyle == other.weekdayTextStyle;

  @override
  int get hashCode =>
      decoration.hashCode ^
      focusedDecoration.hashCode & todayIndicatorColor.hashCode ^
      dateTextStyle.hashCode ^
      weekdayTextStyle.hashCode;
}
