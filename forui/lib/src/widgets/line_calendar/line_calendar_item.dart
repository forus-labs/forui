import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The state of a line calendar item used to build a line calendar item.
typedef FLineCalendarItemData = ({FLineCalendarStyle style, DateTime date, bool today, Set<WidgetState> states});

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
    builder: (context, selected, _) => FTappable(
      style: style.tappableStyle,
      semanticsLabel: (FLocalizations.of(context) ?? FDefaultLocalizations()).fullDate(date),
      selected: selected == date,
      onPress: () => controller.select(date),
      builder: (context, states, _) => builder(
        context,
        (style: style, date: date, today: today, states: states),
        Stack(
          children: [
            Positioned.fill(
              child: ItemContent(style: style, date: date, states: states),
            ),
            if (today)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(color: style.todayIndicatorColor.resolve(states), shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
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
  final DateTime date;
  final Set<WidgetState> states;

  const ItemContent({required this.style, required this.date, required this.states, super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return DecoratedBox(
      decoration: style.decoration.resolve(states),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: style.contentEdgeSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: style.contentSpacing,
          children: [
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.dateTextStyle.resolve(states),
              child: Text(localizations.day(date)),
            ),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.weekdayTextStyle.resolve(states),
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
      ..add(DiagnosticsProperty('date', date))
      ..add(IterableProperty('states', states));
  }
}
