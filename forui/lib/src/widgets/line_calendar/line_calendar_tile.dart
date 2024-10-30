import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar.dart';

//TODO: localizations.
const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _textSpacing = 2.0;

class FlineCalendarTile extends StatelessWidget {
  final FLineCalendarStyle style;
  final FCalendarController controller;
  final DateTime date;
  final bool isToday;

  const FlineCalendarTile({
    required this.style,
    required this.controller,
    required this.date,
    required this.isToday,
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
            semanticLabel: date.toString(),
            onPress: () => controller.select(date),
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
      ..add(DiagnosticsProperty('today', isToday));
  }
}
