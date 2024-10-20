import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_tile.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart' hide FLineCalendar, FLineCalendarContentStyle, FLineCalendarStyle;

const _textSpacing = 2.0;

/// A calendar that can be scrolled horizontally.
class FLineCalendar extends StatefulWidget {
  /// The style. Defaults to [FThemeData.lineCalendarStyle].
  final FLineCalendarStyle? style;

  /// The currently selected [LocalDate].
  final FLineCalendarController controller;

  /// Creates a [FLineCalendar].
  const FLineCalendar({
    required this.controller,
    this.style,
    super.key,
  });

  @override
  State<FLineCalendar> createState() => _FLineCalendarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', controller));
  }
}

class _FLineCalendarState extends State<FLineCalendar> {
  late ScrollController _controller;
  late double _size;
  late FLineCalendarStyle _style;

  @override
  void didChangeDependencies() {
    _style = widget.style ?? FTheme.of(context).lineCalendarStyle;
    _size = _calculateSize(context, _style);

    // TODO: calculate the initial offset based on the selected date. Should this be placed in the controller?
    final offset =
        (widget.controller.value.difference(widget.controller.start).inDays - 2) * _size + _style.itemPadding;
    _controller = ScrollController(initialScrollOffset: offset);

    final textDirection = Directionality.of(context);
    widget.controller.addListener(() => _onDateChange(textDirection));

    super.didChangeDependencies();
  }

  // TODO: calculate width of items based on the text font size.
  double _calculateSize(BuildContext context, FLineCalendarStyle style) {
    final textScalor = MediaQuery.textScalerOf(context);
    final dateTextSize = textScalor.scale(style.content.unselectedDateTextStyle.fontSize!);
    final dayTextSize = textScalor.scale(style.content.unselectedDayTextStyle.fontSize!);
    return dateTextSize + dayTextSize + _textSpacing + (style.content.verticalPadding * 2);
  }

  void _onDateChange(TextDirection textDirection) {
    setState(() {
      //TODO: localizations.
      SemanticsService.announce(widget.controller.value.toString(), textDirection);
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _size,
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemExtent: _size,
          itemBuilder: (context, index) {
            final date = widget.controller.start.add(Duration(days: index));
            return Container(
              padding: EdgeInsets.symmetric(horizontal: _style.itemPadding),
              child: FlineCalendarTile(
                style: _style,
                controller: widget.controller,
                date: date,
                isToday: widget.controller.isToday(date),
              ),
            );
          },
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// [FLineCalendar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The horizontal padding around each calendar item.
  final double itemPadding;

  /// The box decoration for a selected date.
  final BoxDecoration selectedDecoration;

  /// The box decoration for an unselected date.
  final BoxDecoration unselectedDecoration;

  /// The color of the indicator for the selected current date.
  final Color selectedCurrentDateIndicatorColor;

  /// The color of the indicator for the unselected current date.
  final Color unselectedCurrentDateIndicatorColor;

  /// The content's style.
  final FLineCalendarContentStyle content;

  /// Creates a [FLineCalendarStyle].
  const FLineCalendarStyle({
    required this.itemPadding,
    required this.selectedCurrentDateIndicatorColor,
    required this.unselectedCurrentDateIndicatorColor,
    required this.selectedDecoration,
    required this.unselectedDecoration,
    required this.content,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  })  : itemPadding = 6.5,
        selectedCurrentDateIndicatorColor = colorScheme.primaryForeground,
        unselectedCurrentDateIndicatorColor = colorScheme.primary,
        selectedDecoration = BoxDecoration(
          color: colorScheme.primary,
          borderRadius: style.borderRadius,
        ),
        unselectedDecoration = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
          border: Border.all(color: colorScheme.border),
        ),
        content = FLineCalendarContentStyle.inherit(colorScheme: colorScheme, typography: typography);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('selectedCurrentDateIndicatorColor', selectedCurrentDateIndicatorColor))
      ..add(DiagnosticsProperty('unselectedCurrentDateIndicatorColor', unselectedCurrentDateIndicatorColor))
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('content', content));
  }

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  @useResult
  FLineCalendarStyle copyWith({
    double? itemPadding,
    Color? selectedCurrentDateIndicatorColor,
    Color? unselectedCurrentDateIndicatorColor,
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    FLineCalendarContentStyle? content,
  }) =>
      FLineCalendarStyle(
        itemPadding: itemPadding ?? this.itemPadding,
        selectedCurrentDateIndicatorColor: selectedCurrentDateIndicatorColor ?? this.selectedCurrentDateIndicatorColor,
        unselectedCurrentDateIndicatorColor:
            unselectedCurrentDateIndicatorColor ?? this.unselectedCurrentDateIndicatorColor,
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
        content: content ?? this.content,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarStyle &&
          runtimeType == other.runtimeType &&
          itemPadding == other.itemPadding &&
          selectedCurrentDateIndicatorColor == other.selectedCurrentDateIndicatorColor &&
          unselectedCurrentDateIndicatorColor == other.unselectedCurrentDateIndicatorColor &&
          selectedDecoration == other.selectedDecoration &&
          unselectedDecoration == other.unselectedDecoration &&
          content == other.content;

  @override
  int get hashCode =>
      itemPadding.hashCode ^
      selectedCurrentDateIndicatorColor.hashCode ^
      unselectedCurrentDateIndicatorColor.hashCode ^
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      content.hashCode;
}

/// A line calendar's content style.
final class FLineCalendarContentStyle with Diagnosticable {
  /// The vertical padding around the text in the calendar items.
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
  })  : verticalPadding = 15.5,
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
        selectedDayTextStyle = typography.xs.copyWith(
          color: colorScheme.primaryForeground,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
        unselectedDayTextStyle = typography.xs.copyWith(
          color: colorScheme.mutedForeground,
          fontWeight: FontWeight.w500,
          height: 0,
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
