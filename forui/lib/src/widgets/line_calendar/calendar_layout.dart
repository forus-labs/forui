import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_item.dart';

@internal
class CalendarLayout extends StatefulWidget {
  final FCalendarController<DateTime?> controller;
  final FLineCalendarStyle? style;
  final AlignmentDirectional alignment;
  final double? cacheExtent;
  final ValueWidgetBuilder<FLineCalendarItemData> builder;
  final LocalDate start;
  final LocalDate? end;
  final LocalDate? initial;
  final LocalDate today;
  final BoxConstraints constraints;

  const CalendarLayout({
    required this.controller,
    required this.style,
    required this.alignment,
    required this.cacheExtent,
    required this.builder,
    required this.start,
    required this.end,
    required this.initial,
    required this.today,
    required this.constraints,
    super.key,
  });

  @override
  State<CalendarLayout> createState() => _CalendarLayoutState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('initial', initial))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}

class _CalendarLayoutState extends State<CalendarLayout> {
  late FLineCalendarStyle _style;
  ScrollController? _controller;
  double? _width;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = widget.style ?? context.theme.lineCalendarStyle;
    _width = _estimateWidth();

    final initial = widget.initial ?? widget.today;
    final startOffset = (initial.difference(widget.start).inDays) * _width!;
    final offset = switch (widget.alignment.start) {
      -1 => startOffset,
      1 => startOffset - widget.constraints.maxWidth + _width!,
      _ => startOffset - (widget.constraints.maxWidth - _width!) / 2,
    };

    if (_controller != null) {
      _controller!.dispose();
    }

    _controller = ScrollController(initialScrollOffset: offset);
  }

  double _estimateWidth() {
    final scale = MediaQuery.textScalerOf(context);
    final textStyle = DefaultTextStyle.of(context).style;

    double height(FLineCalendarItemStyle style) {
      final dateHeight = scale.scale(style.dateTextStyle.fontSize ?? textStyle.fontSize ?? 0);
      final weekdayHeight = scale.scale(style.weekdayTextStyle.fontSize ?? textStyle.fontSize ?? 0);
      final otherHeight = _style.itemContentSpacing + (_style.itemContentEdgeSpacing * 2);

      return dateHeight + weekdayHeight + otherHeight;
    }

    // We use the height to estimate the width.
    return [
      height(_style.selectedItemStyle),
      height(_style.selectedHoveredItemStyle),
      height(_style.unselectedItemStyle),
      height(_style.unselectedHoveredItemStyle),
    ].max!;
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = widget.today.toNative();
    return SpeculativeLayout(
      children: [
        ItemContent(
          style: _style,
          itemStyle: _style.selectedItemStyle,
          date: placeholder,
          hovered: false,
          focused: false,
        ),
        ItemContent(
          style: _style,
          itemStyle: _style.selectedItemStyle,
          date: placeholder,
          hovered: true,
          focused: false,
        ),
        ItemContent(
          style: _style,
          itemStyle: _style.unselectedItemStyle,
          date: placeholder,
          hovered: false,
          focused: false,
        ),
        ItemContent(
          style: _style,
          itemStyle: _style.unselectedItemStyle,
          date: placeholder,
          hovered: true,
          focused: false,
        ),
        ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          cacheExtent: widget.cacheExtent,
          itemExtent: _width!,
          itemCount: widget.end != null ? widget.end!.difference(widget.start).inDays + 1 : null,
          itemBuilder: (context, index) {
            final date = widget.start.plus(days: index);
            return Padding(
              padding: _style.itemPadding,
              child: Item(
                style: _style,
                controller: widget.controller,
                date: date.toNative(),
                today: widget.today == date,
                builder: widget.builder,
              ),
            );
          },
        ),
      ],
    );
  }
}

@internal
class SpeculativeLayout extends MultiChildRenderObjectWidget {
  const SpeculativeLayout({
    required super.children,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => _SpeculativeBox();
}

class _Data extends ContainerBoxParentData<RenderBox> {}

class _SpeculativeBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  @override
  void setupParentData(RenderObject child) => child.parentData = _Data();

  @override
  void performLayout() {
    final selected = firstChild!;
    final selectedHovered = childAfter(selected)!;
    final unselected = childAfter(selectedHovered)!;
    final unselectedHovered = childAfter(unselected)!;

    final maxHeight = [
      selected.getDryLayout(constraints).height,
      selectedHovered.getDryLayout(constraints).height,
      unselected.getDryLayout(constraints).height,
      unselectedHovered.getDryLayout(constraints).height,
    ].max!;

    final heightConstraints = constraints.copyWith(maxHeight: maxHeight);
    final viewport = childAfter(unselectedHovered)!..layout(heightConstraints, parentUsesSize: true);
    size = constraints.constrain(viewport.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) => context.paintChild(lastChild!, offset);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final viewport = lastChild!;
    return result.addWithPaintOffset(
      offset: viewport.data.offset,
      position: position,
      hitTest: (result, transformed) => viewport.hitTest(result, position: transformed),
    );
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    visitor(lastChild!);
  }
}
