import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:meta/meta.dart';

import 'package:sugar/sugar.dart';

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
final _epoch = LocalDate(2000);

/// A calendar that can be scrolled horizontally.
class FLineCalendar extends StatefulWidget {
  /// The style. Defaults to [FThemeData.lineCalendarStyle].
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FLineCalendarStyle?>('style', style))
      ..add(DiagnosticsProperty<ValueNotifier<LocalDate>>('selected', selected))
      ..add(DiagnosticsProperty<LocalDate>('epoch', epoch))
      ..add(DiagnosticsProperty<LocalDate>('today', today));
  }
}

class _FLineCalendarState extends State<FLineCalendar> {
  late ScrollController _controller = ScrollController();
  late double _width;

  @override
  void initState() {
    widget.selected.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            _width = constraints.maxWidth / 5;
          } else if (constraints.maxWidth >= 450 && constraints.maxWidth <= 650) {
            _width = constraints.maxWidth / 7;
          } else {
            _width = constraints.maxWidth / 10;
          }
          final offset = (widget.selected.value.difference(widget.epoch).inDays - 2) * _width;
          _controller = ScrollController(initialScrollOffset: offset);
          return SizedBox(
            height: _width*0.9,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemExtent: _width,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: (_width * 0.2) / 2),
                child: _Tile(
                  style: widget.style,
                  selected: widget.selected,
                  date: widget.epoch.add(Duration(days: index)),
                  today: widget.today,
                ),
              ),
            ),
          );
        },
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

  TextStyle _style(BuildContext context, bool selected) {
    final style = this.style ?? context.theme.lineCalendarStyle;
    return switch ((selected, underline)) {
      (true, true) => style.selectedTextStyle.copyWith(decoration: TextDecoration.underline),
      (true, false) => style.selectedTextStyle,
      (false, true) => style.unselectedTextStyle.copyWith(decoration: TextDecoration.underline),
      (false, false) => style.unselectedTextStyle,
    };
  }

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.lineCalendarStyle;
    final selected = this.selected.value == date;

    return FTappable.animated(
      onPress: () => this.selected.value = date,
      child: DecoratedBox(
        decoration: selected ? style.selectedDecoration : style.unselectedDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: selected ? style.selectedDateTextStyle : style.unselectedDateTextStyle,
            ),
            const SizedBox(height: 2),
            Text(
              _days[date.weekday - 1],
              style: _style(context, selected),
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
      ..add(DiagnosticsProperty<ValueNotifier<LocalDate>>('selected', selected))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('underline', underline));
  }
}

/// [FAvatar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The box decoration for a selected date.
  final BoxDecoration selectedDecoration;

  /// The box decoration for an unselected date.
  final BoxDecoration unselectedDecoration;

  /// The box decoration for an unselected date.
  final BoxDecoration unselectedDateDecoration;

  /// The box decoration for a selected date.
  final BoxDecoration selectedDateDecoration;

  /// The text style for the selected date.
  final TextStyle selectedDateTextStyle;

  /// The text style for an unselected date.
  final TextStyle unselectedDateTextStyle;

  /// The text style for the selected date.
  final TextStyle selectedTextStyle;

  /// The text style for an unselected date.
  final TextStyle unselectedTextStyle;

  /// Creates a [FLineCalendarStyle].
  const FLineCalendarStyle({
    required this.selectedDecoration,
    required this.unselectedDecoration,
    required this.selectedDateDecoration,
    required this.unselectedDateDecoration,
    required this.selectedDateTextStyle,
    required this.unselectedDateTextStyle,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  })  : selectedDecoration = BoxDecoration(
          color: colorScheme.primary,
          borderRadius: style.borderRadius,
        ),
        unselectedDecoration = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
          border: Border.all(color: colorScheme.border),
        ),
        selectedDateDecoration = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
          border: Border.all(color: colorScheme.border),
        ),
        unselectedDateDecoration = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
        ),
        selectedDateTextStyle = typography.xl.copyWith(
          color: colorScheme.primaryForeground,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
        unselectedDateTextStyle = typography.xl.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
        selectedTextStyle = typography.xs.copyWith(
          color: colorScheme.primaryForeground,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        unselectedTextStyle = typography.xs.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
          height: 0,
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle))
      ..add(DiagnosticsProperty('unselectedTextStyle', unselectedTextStyle));
  }

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FLineCalendarStyle(
  ///   selectedDecoration: ...,
  ///   unselectedDecoration: ...,
  /// );
  ///
  /// final copy = style.copyWith(unselectedDecoration: ...);
  ///
  /// print(style.selectedDecoration == copy.selectedDecoration); // true
  /// print(style.unselectedDecoration == copy.unselectedDecoration); // false
  /// ```
  @useResult
  FLineCalendarStyle copyWith({
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    BoxDecoration? selectedDateDecoration,
    BoxDecoration? unselectedDateDecoration,
    TextStyle? selectedDateTextStyle,
    TextStyle? unselectedDateTextStyle,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
  }) =>
      FLineCalendarStyle(
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
        selectedDateDecoration: selectedDateDecoration ?? this.selectedDateDecoration,
        unselectedDateDecoration: unselectedDateDecoration ?? this.unselectedDateDecoration,
        selectedDateTextStyle: selectedDateTextStyle ?? this.selectedDateTextStyle,
        unselectedDateTextStyle: unselectedDateTextStyle ?? this.unselectedDateTextStyle,
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarStyle &&
          runtimeType == other.runtimeType &&
          selectedDecoration == other.selectedDecoration &&
          unselectedDecoration == other.unselectedDecoration &&
          selectedDateDecoration == other.selectedDateDecoration &&
          unselectedDateDecoration == other.unselectedDateDecoration &&
          selectedTextStyle == other.selectedTextStyle &&
          unselectedTextStyle == other.unselectedTextStyle;

  @override
  int get hashCode =>
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      selectedDateDecoration.hashCode ^
      unselectedDateDecoration.hashCode ^
      selectedTextStyle.hashCode ^
      unselectedTextStyle.hashCode;
}
