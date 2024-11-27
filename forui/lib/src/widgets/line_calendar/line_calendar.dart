import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_item.dart';
import 'package:forui/src/widgets/line_calendar/speculative_layout.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

/// A line calendar displays dates in a single horizontal, scrollable line.
class FLineCalendar extends StatefulWidget {
  /// The controller.
  final FCalendarController<DateTime?> controller;

  /// The style.
  final FLineCalendarStyle? style;

  final LocalDate _start;
  final LocalDate? _end;
  final LocalDate? _initial;
  final LocalDate _today;

  /// Creates a [FLineCalendar].
  ///
  /// [start] represents the start date, inclusive. It is truncated to the nearest date. Defaults to the
  /// [DateTime.utc(1900)].
  ///
  /// [end] represents the end date, exclusive. It is truncated to the nearest date.
  ///
  /// [initial] represents the initial date that will appear on the left-most edge on LTR locales. It is truncated to
  /// the nearest date.
  ///
  /// [today] represents the current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [end] <= [start].
  /// * [initial] < [start] or [end] <= [initial].
  /// * [today] < [start] or [end] <= [today].
  FLineCalendar({
    required this.controller,
    this.style,
    DateTime? start,
    DateTime? end,
    DateTime? initial,
    DateTime? today,
    super.key,
  })  : _start = (start ?? DateTime.utc(1900)).toLocalDate(),
        _end = end?.toLocalDate(),
        _initial = initial?.toLocalDate(),
        _today = (today ?? DateTime.now()).toLocalDate(),
        assert(
          start == null || end == null || start.toLocalDate() < end.toLocalDate(),
          'end date must be greater than start date',
        ),
        assert(
          initial == null ||
              start == null ||
              (initial.toLocalDate() >= start.toLocalDate() && initial.toLocalDate() < end!.toLocalDate()),
          'initial date must be greater than or equal to start date',
        ),
        assert(
          today == null ||
              start == null ||
              (today.toLocalDate() >= start.toLocalDate() && today.toLocalDate() < end!.toLocalDate()),
          'initial date must be greater than or equal to start date',
        );

  @override
  State<FLineCalendar> createState() => _FLineCalendarState();
}

class _FLineCalendarState extends State<FLineCalendar> {
  late FLineCalendarStyle _style;
  ScrollController? _controller;
  double? _width;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = widget.style ?? context.theme.lineCalendarStyle;
    _width = _estimateWidth();

    final initial = widget._initial ?? widget._today;
    final offset = (initial.difference(widget._start).inDays) * _width! + _style.itemPadding.horizontal;

    if (_controller != null) {
      _controller!.dispose();
    }

    _controller = ScrollController(initialScrollOffset: offset);
  }

  double _estimateWidth() {
    final scale = MediaQuery.textScalerOf(context);
    final textStyle = DefaultTextStyle.of(context).style;
    final itemStyle = _style.itemStyle;

    double height(FLineCalendarItemStateStyle style) {
      final dateHeight = scale.scale(style.dateTextStyle.fontSize ?? textStyle.fontSize ?? 0);
      final weekdayHeight = scale.scale(style.weekdayTextStyle.fontSize ?? textStyle.fontSize ?? 0);
      final otherHeight = itemStyle.dateSpacing + (itemStyle.contentSpacing * 2);

      return dateHeight + weekdayHeight + otherHeight;
    }

    // We use the height to estimate the width.
    return [
      height(itemStyle.selectedItemStyle),
      height(itemStyle.selectedHoveredItemStyle),
      height(itemStyle.unselectedItemStyle),
      height(itemStyle.unselectedHoveredItemStyle),
    ].max!;
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = widget._today.toNative();
    return SpeculativeLayout(
      children: [
        ItemContent(
          style: _style.itemStyle,
          stateStyle: _style.itemStyle.selectedItemStyle,
          width: _width!,
          date: placeholder,
          today: false,
          hovered: false,
          focused: false,
        ),
        ItemContent(
          style: _style.itemStyle,
          stateStyle: _style.itemStyle.selectedItemStyle,
          width: _width!,
          date: placeholder,
          today: false,
          hovered: true,
          focused: false,
        ),
        ItemContent(
          style: _style.itemStyle,
          stateStyle: _style.itemStyle.unselectedItemStyle,
          width: _width!,
          date: placeholder,
          today: false,
          hovered: false,
          focused: false,
        ),
        ItemContent(
          style: _style.itemStyle,
          stateStyle: _style.itemStyle.unselectedItemStyle,
          width: _width!,
          date: placeholder,
          today: false,
          hovered: true,
          focused: false,
        ),
        ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemExtent: _width!,
          itemCount: widget._end != null ? widget._end!.difference(widget._start).inDays + 1 : null,
          itemBuilder: (context, index) {
            final date = widget._start.plus(days: index);
            return Padding(
              padding: _style.itemPadding,
              child: Item(
                style: _style.itemStyle,
                width: _width!,
                controller: widget.controller,
                date: date.toNative(),
                today: widget._today == date,
              ),
            );
          },
        ),
      ],
    );
  }
}

/// [FLineCalendar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  final EdgeInsets itemPadding;

  /// The calendar item's style.
  final FLineCalendarItemStyle itemStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.itemStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 6.5),
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          itemStyle: FLineCalendarItemStyle.inherit(
            colorScheme: colorScheme,
            typography: typography,
            style: style,
          ),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsets? itemPadding,
    FLineCalendarItemStyle? itemStyle,
  }) =>
      FLineCalendarStyle(
        itemPadding: itemPadding ?? this.itemPadding,
        itemStyle: itemStyle ?? this.itemStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarStyle &&
          runtimeType == other.runtimeType &&
          itemPadding == other.itemPadding &&
          itemStyle == other.itemStyle;

  @override
  int get hashCode => itemPadding.hashCode ^ itemStyle.hashCode;
}
