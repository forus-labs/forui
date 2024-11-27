import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

@internal
class LineCalendar extends StatefulWidget {
  final FCalendarController<DateTime?> controller;
  final FLineCalendarStyle? style;
  final BoxConstraints constraints;
  final LocalDate _start;
  final LocalDate? _end;
  final LocalDate _initial;
  final LocalDate _today;

  const LineCalendar({
    required this.controller,
    required this.style,
    required this.constraints,
    required LocalDate start,
    required LocalDate? end,
    required LocalDate initial,
    required LocalDate today,
    super.key,
  })  : _start = start,
        _end = end,
        _initial = initial,
        _today = today;

  @override
  State<LineCalendar> createState() => _LineCalendarState();
}

class _LineCalendarState extends State<LineCalendar> {
  @override
  Widget build(BuildContext context) => const Placeholder();
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
    final unselected = childAfter(selected)!;

    final selectedHeight = selected.getDryLayout(constraints).height;
    final unselectedHeight = unselected.getDryLayout(constraints).height;

    final heightConstraints = constraints.copyWith(maxHeight: max(selectedHeight, unselectedHeight));
    final viewport = childAfter(unselected)!..layout(heightConstraints, parentUsesSize: true);
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
}
