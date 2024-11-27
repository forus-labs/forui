import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_item.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';

const _textSpacing = 2.0;

/// A line calendar displays dates in a single horizontal, scrollable line.
class FLineCalendar extends StatefulWidget {
  /// The controller.
  final FCalendarController<DateTime?> controller;

  /// The style.
  final FLineCalendarStyle? style;

  final LocalDate _start;

  final LocalDate? _end;

  final LocalDate _today;

  /// Creates a [FLineCalendar].
  ///
  /// [today] represents the current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  /// [start] represents the start date. It is truncated to the nearest date. Defaults to the [DateTime.utc(1900)].
  /// [end] represents the end date. It is truncated to the nearest date.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [end] <= [start].
  FLineCalendar({
    required this.controller,
    this.style,
    DateTime? start,
    DateTime? end,
    DateTime? today,
    super.key,
  })  : _start = (start ?? DateTime.utc(1900)).toLocalDate(),
        _end = end?.toLocalDate(),
        _today = (today ?? DateTime.now()).toLocalDate(),
        assert(
          start == null || end == null || start.toLocalDate() < end.toLocalDate(),
          'end date must be greater than start date',
        );

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
  ScrollController? _controller;
  late double _size;
  late FLineCalendarStyle _style;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = widget.style ?? context.theme.lineCalendarStyle;
    _size = _calculateSize(context, _style);

    final value = widget.controller.value?.toLocalDate() ?? widget._today;
    final offset = (value.difference(widget._start).inDays - 2) * _size + _style.itemPadding.horizontal;

    if (_controller != null) {
      _controller!.dispose();
    }

    _controller = ScrollController(initialScrollOffset: offset);
  }

  // TODO: calculate width of items based on the text font size.
  double _calculateSize(BuildContext context, FLineCalendarStyle style) {
    final textScalor = MediaQuery.textScalerOf(context);
    final dateTextSize = textScalor.scale(style.itemStyle.unselectedItemStyle.dateTextStyle.fontSize!);
    final dayTextSize = textScalor.scale(style.itemStyle.unselectedItemStyle.weekdayTextStyle.fontSize!);
    return dateTextSize + dayTextSize + _textSpacing + (style.itemStyle.contentSpacing * 2);
  }

  @override
  Widget build(BuildContext context) => _Calendar(children: [
        ItemContent(
          style: _style.itemStyle,
          stateStyle: _style.itemStyle.selectedItemStyle,
          width: _size,
          date: DateTime.now(),
          today: false,
          hovered: false,
          focused: true,
        ),
        ItemContent(
          style: _style.itemStyle,
          stateStyle: _style.itemStyle.unselectedItemStyle,
          width: _size,
          date: DateTime.now(),
          today: false,
          hovered: false,
          focused: true,
        ),
        ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemExtent: _size,
          itemCount: widget._end != null ? widget._end!.difference(widget._start).inDays + 1 : null,
          itemBuilder: (context, index) {
            final date = widget._start.add(Duration(days: index));
            return Padding(
              padding: _style.itemPadding,
              child: Item(
                style: _style.itemStyle,
                width: 52,
                controller: widget.controller,
                date: date.toNative(),
                today: widget._today == date,
              ),
            );
          },
        ),
      ]);

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
