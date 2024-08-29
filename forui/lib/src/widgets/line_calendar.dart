import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:meta/meta.dart';

import 'package:sugar/sugar.dart';

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
final _epoch = LocalDate(2000);
const _textSpacing = 2.0;

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
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('epoch', epoch))
      ..add(DiagnosticsProperty('today', today));
  }
}

class _FLineCalendarState extends State<FLineCalendar> {
  late ScrollController _controller = ScrollController();

  @override
  void initState() {
    widget.selected.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.lineCalendarStyle;

    final textScalor = MediaQuery.textScalerOf(context);
    final dateTextSize = textScalor.scale(style.unselectedDateTextStyle.fontSize!);
    final dayTextSize = textScalor.scale(style.unselectedTextStyle.fontSize!);
    final size = dateTextSize + dayTextSize + _textSpacing + (style.heightPadding * 2);

    final offset = (widget.selected.value.difference(widget.epoch).inDays - 2) * size + style.itemPadding;
    _controller = ScrollController(initialScrollOffset: offset);

    return SizedBox(
      height: size,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        // TODO: calculate width of items based on the text font size.
        itemExtent: size,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: style.itemPadding),
          child: _Tile(
            style: widget.style,
            selected: widget.selected,
            date: widget.epoch.add(Duration(days: index)),
            today: widget.today,
          ),
        ),
      ),
    );
  }

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
  final bool today;

  const _Tile({required this.selected, required this.date, required LocalDate today, this.style})
      : today = date == today;

  Color _style(BuildContext context, bool selected) {
    final style = this.style ?? context.theme.lineCalendarStyle;
    return switch ((selected, today)) {
      (true, true) => style.selectedIndicatorColor,
      (true, false) => const Color(0x00000000),
      (false, true) => style.unselectedIndicatorColor,
      (false, false) => const Color(0x00000000),
    };
  }

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.lineCalendarStyle;
    final selected = this.selected.value == date;

    return FTappable.animated(
      onPress: () => this.selected.value = date,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: selected ? style.selectedDecoration : style.unselectedDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
                  merge(
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    style: selected ? style.selectedDateTextStyle : style.unselectedDateTextStyle,
                    child: Text(date.day.toString()),
                  ),
                  const SizedBox(height: _textSpacing),
                  // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
                  merge(
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
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
                color: _style(context, selected),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('underline', today));
  }
}

/// [FAvatar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The vertical padding around the text.
  final double heightPadding;

  /// The horizontal padding around each date item.
  final double itemPadding;

  /// The box decoration for a selected date.
  final BoxDecoration selectedDecoration;

  /// The box decoration for an unselected date.
  final BoxDecoration unselectedDecoration;

  /// The color of the indicator for the current date when it is selected.
  final Color selectedIndicatorColor;

  /// The color of the indicator for the current date when it is not selected.
  final Color unselectedIndicatorColor;

  /// The color of .
  final TextStyle selectedDateTextStyle;

  /// The text style for an unselected date.
  final TextStyle unselectedDateTextStyle;

  /// The text style for the selected date.
  final TextStyle selectedTextStyle;

  /// The text style for an unselected date.
  final TextStyle unselectedTextStyle;

  /// Creates a [FLineCalendarStyle].
  const FLineCalendarStyle({
    required this.heightPadding,
    required this.itemPadding,
    required this.selectedIndicatorColor,
    required this.unselectedIndicatorColor,
    required this.selectedDecoration,
    required this.unselectedDecoration,
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
  })  : heightPadding = 15.5,
        itemPadding = 6.5,
        selectedIndicatorColor = colorScheme.primaryForeground,
        unselectedIndicatorColor = colorScheme.primary,
        selectedDecoration = BoxDecoration(
          color: colorScheme.primary,
          borderRadius: style.borderRadius,
        ),
        unselectedDecoration = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
          border: Border.all(color: colorScheme.border),
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
          fontWeight: FontWeight.w500,
          height: 0,
        ),
        unselectedTextStyle = typography.xs.copyWith(
          color: colorScheme.mutedForeground,
          fontWeight: FontWeight.w500,
          height: 0,
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle))
      ..add(DiagnosticsProperty('unselectedTextStyle', unselectedTextStyle))
      ..add(ColorProperty('primary', selectedIndicatorColor))
      ..add(DoubleProperty('heightPadding', heightPadding))
      ..add(DoubleProperty('itemPadding', itemPadding))
      ..add(ColorProperty('unselectedIndicatorColor', unselectedIndicatorColor))
      ..add(DiagnosticsProperty('selectedDateTextStyle', selectedDateTextStyle))
      ..add(DiagnosticsProperty('unselectedDateTextStyle', unselectedDateTextStyle));
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
    double? heightPadding,
    double? itemPadding,
    Color? primary,
    Color? primaryForeground,
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    TextStyle? selectedDateTextStyle,
    TextStyle? unselectedDateTextStyle,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
  }) =>
      FLineCalendarStyle(
        heightPadding: heightPadding ?? this.heightPadding,
        itemPadding: itemPadding ?? this.itemPadding,
        selectedIndicatorColor: primary ?? this.selectedIndicatorColor,
        unselectedIndicatorColor: primaryForeground ?? this.unselectedIndicatorColor,
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
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
          heightPadding == other.heightPadding &&
          itemPadding == other.itemPadding &&
          selectedIndicatorColor == other.selectedIndicatorColor &&
          unselectedIndicatorColor == other.unselectedIndicatorColor &&
          selectedDecoration == other.selectedDecoration &&
          unselectedDecoration == other.unselectedDecoration &&
          selectedTextStyle == other.selectedTextStyle &&
          unselectedTextStyle == other.unselectedTextStyle;

  @override
  int get hashCode =>
      heightPadding.hashCode ^
      itemPadding.hashCode ^
      selectedIndicatorColor.hashCode ^
      unselectedIndicatorColor.hashCode ^
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      selectedTextStyle.hashCode ^
      unselectedTextStyle.hashCode;
}
