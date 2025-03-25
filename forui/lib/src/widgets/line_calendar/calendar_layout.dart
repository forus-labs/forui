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
  final FLineCalendarStyle style;
  final AlignmentDirectional alignment;
  final double? cacheExtent;
  final TextScaler scale;
  final TextStyle textStyle;
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
    required this.scale,
    required this.textStyle,
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
      ..add(DiagnosticsProperty('scaler', scale))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('initial', initial))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}

class _CalendarLayoutState extends State<CalendarLayout> {
  late ScrollController _scrollController;
  late double _width;

  @override
  @override
  void initState() {
    super.initState();
    _width = _estimateWidth();

    final start = ((widget.initial ?? widget.today).difference(widget.start).inDays) * _width;
    _scrollController = ScrollController(
      initialScrollOffset: switch (widget.alignment.start) {
        -1 => start,
        1 => start - widget.constraints.maxWidth + _width,
        _ => start - (widget.constraints.maxWidth - _width) / 2,
      },
    );
  }

  @override
  void didUpdateWidget(covariant CalendarLayout old) {
    super.didUpdateWidget(old);
    if (widget.style != old.style || widget.scale != old.scale || widget.textStyle != old.textStyle) {
      _width = _estimateWidth();
    }
  }

  double _estimateWidth() {
    double height(FLineCalendarItemStyle style) {
      final dateHeight = widget.scale.scale(style.dateTextStyle.fontSize ?? widget.textStyle.fontSize ?? 0);
      final weekdayHeight = widget.scale.scale(style.weekdayTextStyle.fontSize ?? widget.textStyle.fontSize ?? 0);
      final otherHeight = widget.style.itemContentSpacing + (widget.style.itemContentEdgeSpacing * 2);

      return dateHeight + weekdayHeight + otherHeight;
    }

    // We use the height to estimate the width.
    return [
      height(widget.style.selectedItemStyle),
      height(widget.style.selectedHoveredItemStyle),
      height(widget.style.unselectedItemStyle),
      height(widget.style.unselectedHoveredItemStyle),
    ].max!;
  }

  @override
  Widget build(BuildContext _) {
    final placeholder = widget.today.toNative();
    return SpeculativeLayout(
      children: [
        ItemContent(
          style: widget.style,
          itemStyle: widget.style.selectedItemStyle,
          date: placeholder,
          hovered: false,
          focused: false,
        ),
        ItemContent(
          style: widget.style,
          itemStyle: widget.style.selectedItemStyle,
          date: placeholder,
          hovered: true,
          focused: false,
        ),
        ItemContent(
          style: widget.style,
          itemStyle: widget.style.unselectedItemStyle,
          date: placeholder,
          hovered: false,
          focused: false,
        ),
        ItemContent(
          style: widget.style,
          itemStyle: widget.style.unselectedItemStyle,
          date: placeholder,
          hovered: true,
          focused: false,
        ),
        ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          cacheExtent: widget.cacheExtent,
          itemExtent: _width,
          itemCount: widget.end == null ? null : widget.end!.difference(widget.start).inDays + 1,
          itemBuilder: (_, index) {
            final date = widget.start.plus(days: index);
            return Padding(
              padding: widget.style.itemPadding,
              child: Item(
                controller: widget.controller,
                style: widget.style,
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

@internal
class SpeculativeLayout extends MultiChildRenderObjectWidget {
  const SpeculativeLayout({required super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext _) => _SpeculativeBox();
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

    final maxHeight =
        [
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
  void visitChildrenForSemantics(RenderObjectVisitor visitor) => visitor(lastChild!);
}
