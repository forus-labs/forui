import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:meta/meta.dart';

@internal
class LineCalendar extends StatefulWidget {
  final FCalendarController<DateTime?> controller;
  final FLineCalendarStyle? style;
  final BoxConstraints constraints;
  final LocalDate _start;
  final LocalDate? _end;
  final LocalDate _today;

  const LineCalendar({super.key,
      required this.controller,
      required this.style,
      required this.constraints,
      this._start,
      this._end,
      this._today,
      });

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
