import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

import 'package:sugar/sugar.dart';

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
final _epoch = LocalDate(2000);

class FLineCalendar extends StatefulWidget {
  final FLineCalendarStyle? style;

  /// The currently selected [LocalDate].
  final ValueNotifier<LocalDate> selected;

  /// The first date in this calendar carousel. Defaults to 1st January 2000.
  final LocalDate epoch;

  /// Today's date. Defaults to the [LocalDate.now].
  final LocalDate today;

  /// Creates a [FLineCalendar].
  FLineCalendar({
    required this.selected,
    LocalDate? epoch,
    LocalDate? today,
    this.style,
    super.key,
  })  : epoch = epoch ?? _epoch,
        today = today ?? LocalDate.now();

  @override
  State<FLineCalendar> createState() => _FLineCalendarState();
}

class _FLineCalendarState extends State<FLineCalendar> {
  late final ScrollController _controller;
  late final double _width;

  @override
  void initState() {
    widget.selected.addListener(() => setState(() {}));
    final mediaQuery = (context.getElementForInheritedWidgetOfExactType<MediaQuery>()!.widget as MediaQuery).data;
    _width = mediaQuery.size.width / 5;
    final offset = (widget.selected.value.difference(widget.epoch).inDays - 2) * _width;
    _controller = ScrollController(initialScrollOffset: offset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 85,
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemExtent: _width,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: (_width - 55) / 2),
            child: _Tile(
              style: widget.style,
              selected: widget.selected,
              date: widget.epoch.add(Duration(days: index)),
              today: widget.today,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class _Tile extends StatelessWidget {
  final FLineCalendarStyle? style;
  final ValueNotifier<LocalDate> selected;
  final LocalDate date;
  final bool underline;

  const _Tile({required this.selected, required this.date, required LocalDate today, this.style})
      : underline = date == today;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.lineCalendarStyle;
    final selected = this.selected.value == date;

    return FTappable.animated(
      onPress: () => this.selected.value = date,
      child: Container(
        alignment: Alignment.center,
        width: 55,
        height: 85,
        padding: const EdgeInsets.all(8),
        decoration: selected ? style.selectedDecoration : null,
        child: Column(
          children: [
            _Date(
              date: date,
              selected: selected,
              underline: underline,
              style: style,
            ),
            const SizedBox(height: 5),
            Text(
              _days[date.weekday - 1],
              style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _Date extends StatelessWidget {
  final FLineCalendarStyle? style;
  final LocalDate date;
  final bool selected;
  final bool underline;

  const _Date({required this.date, required this.selected, required this.underline, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.lineCalendarStyle;
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 40,
      decoration: style.dateDecoration,
      child: Text(
        date.day.toString(),
        style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
      ),
    );
  }
}

/// [FAvatar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The fallback's background color.
  final Color backgroundColor;

  /// The fallback's color.
  final Color foregroundColor;

  final BoxDecoration dateDecoration;

  final BoxDecoration selectedDecoration;

  /// The text style for the selected date.
  final TextStyle selectedTextStyle;

  /// The text style for the selected date.
  final TextStyle unselectedTextStyle;

  /// Creates a [FLineCalendarStyle].
  const FLineCalendarStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.dateDecoration,
    required this.selectedDecoration,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarStyle.inherit(
      {required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : backgroundColor = colorScheme.muted,
        foregroundColor = colorScheme.mutedForeground,
        dateDecoration = BoxDecoration(
          color: colorScheme.foreground,
          borderRadius: style.borderRadius,
        ),
        selectedDecoration = BoxDecoration(
          color: colorScheme.primary,
          borderRadius: style.borderRadius,
          border: Border.all(color: colorScheme.border),
        ),
        selectedTextStyle = typography.base.copyWith(
          color: colorScheme.mutedForeground,
          height: 0,
        ),
        unselectedTextStyle = typography.base.copyWith(
          color: colorScheme.mutedForeground,
          height: 0,
        );
}
