import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

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
