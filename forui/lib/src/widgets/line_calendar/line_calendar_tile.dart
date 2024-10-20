
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar.dart';
import 'package:sugar/sugar.dart';

//TODO: localizations.
const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
final _start = (DateTime(1900), null);
const _textSpacing = 2.0;

class FlineCalendarTile extends StatelessWidget {
  final FLineCalendarStyle style;
  final ValueNotifier<LocalDate> selected;
  final LocalDate date;
  final bool today;

  const FlineCalendarTile({
    required this.style,
    required this.selected,
    required this.date,
    required LocalDate today,
  }) : today = date == today;

  Color _style(BuildContext context, bool selected) => switch ((selected, today)) {
    (true, true) => style.selectedCurrentDateIndicatorColor,
    (true, false) => const Color(0x00000000),
    (false, true) => style.unselectedCurrentDateIndicatorColor,
    (false, false) => const Color(0x00000000),
  };

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: selected,
    builder: (context, selectedDate, _) {
      final isSelected = selectedDate == date;
      return FTappable.animated(
        semanticLabel: date.toString(),
        selected: isSelected,
        onPress: () => selected.value = date,
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
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('today', today));
  }
}