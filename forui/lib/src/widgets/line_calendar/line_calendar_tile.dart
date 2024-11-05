import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar.dart';

//TODO: localizations.
const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _textSpacing = 2.0;

@internal
class FLineCalendarTile extends StatelessWidget {
  final FLineCalendarStyle style;
  final FCalendarController controller;
  final FocusNode focusNode;
  final DateTime date;
  final bool isToday;

  const FLineCalendarTile({
    required this.style,
    required this.controller,
    required this.focusNode,
    required this.date,
    required this.isToday,
    super.key,
  });

  Color _style(BuildContext context, bool selected) => switch ((selected, isToday)) {
        (true, true) => style.selectedCurrentDateIndicatorColor,
        (true, false) => const Color(0x00000000),
        (false, true) => style.unselectedCurrentDateIndicatorColor,
        (false, false) => const Color(0x00000000),
      };

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, selectedDate, _) {
          final isSelected = controller.selected(date);
          return FTappable.animated(
            semanticLabel: date.toString(), // TODO: Localization
            onPress: () {
              focusNode.requestFocus();
              controller.select(date);
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: isSelected ? style.selectedDecoration : style.unselectedDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
                        merge(
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                          style:
                              isSelected ? style.content.selectedDateTextStyle : style.content.unselectedDateTextStyle,
                          //TODO: Localization.
                          child: Text('${date.day}'),
                        ),
                        const SizedBox(height: _textSpacing),
                        // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
                        merge(
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                          style: isSelected ? style.content.selectedDayTextStyle : style.content.unselectedDayTextStyle,
                          child: Text(_days[date.weekday - 1]),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: _style(context, isSelected),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('today', value: isToday, ifTrue: 'today'))
      ..add(DiagnosticsProperty('controller', controller));
  }
}

/// A line calendar's content style.
final class FLineCalendarContentStyle with Diagnosticable {
  /// The vertical height around the text in the calendar items.
  final double verticalPadding;

  /// The text style for the selected date.
  final TextStyle selectedDateTextStyle;

  /// The text style for the unselected date.
  final TextStyle unselectedDateTextStyle;

  /// The text style for the selected day of the week.
  final TextStyle selectedDayTextStyle;

  /// The text style for the unselected day of the week.
  final TextStyle unselectedDayTextStyle;

  /// Creates a [FLineCalendarContentStyle].
  const FLineCalendarContentStyle({
    required this.verticalPadding,
    required this.selectedDateTextStyle,
    required this.unselectedDateTextStyle,
    required this.selectedDayTextStyle,
    required this.unselectedDayTextStyle,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarContentStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
  }) : this(
          verticalPadding: 15.5,
          selectedDateTextStyle: typography.xl.copyWith(
            color: colorScheme.primaryForeground,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
          unselectedDateTextStyle: typography.xl.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
          selectedDayTextStyle: typography.xs.copyWith(
            color: colorScheme.primaryForeground,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
          unselectedDayTextStyle: typography.xs.copyWith(
            color: colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('verticalPadding', verticalPadding))
      ..add(DiagnosticsProperty('selectedDateTextStyle', selectedDateTextStyle))
      ..add(DiagnosticsProperty('unselectedDateTextStyle', unselectedDateTextStyle))
      ..add(DiagnosticsProperty('selectedDayTextStyle', selectedDayTextStyle))
      ..add(DiagnosticsProperty('unselectedDayTextStyle', unselectedDayTextStyle));
  }

  /// Returns a copy of this [FLineCalendarContentStyle] with the given properties replaced.
  @useResult
  FLineCalendarContentStyle copyWith({
    double? verticalPadding,
    TextStyle? selectedDateTextStyle,
    TextStyle? unselectedDateTextStyle,
    TextStyle? selectedDayTextStyle,
    TextStyle? unselectedDayTextStyle,
  }) =>
      FLineCalendarContentStyle(
        verticalPadding: verticalPadding ?? this.verticalPadding,
        selectedDateTextStyle: selectedDateTextStyle ?? this.selectedDateTextStyle,
        unselectedDateTextStyle: unselectedDateTextStyle ?? this.unselectedDateTextStyle,
        selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
        unselectedDayTextStyle: unselectedDayTextStyle ?? this.unselectedDayTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarContentStyle &&
          runtimeType == other.runtimeType &&
          verticalPadding == other.verticalPadding &&
          selectedDateTextStyle == other.selectedDateTextStyle &&
          unselectedDateTextStyle == other.unselectedDateTextStyle &&
          selectedDayTextStyle == other.selectedDayTextStyle &&
          unselectedDayTextStyle == other.unselectedDayTextStyle;

  @override
  int get hashCode =>
      verticalPadding.hashCode ^
      selectedDateTextStyle.hashCode ^
      unselectedDateTextStyle.hashCode ^
      selectedDayTextStyle.hashCode ^
      unselectedDayTextStyle.hashCode;
}
