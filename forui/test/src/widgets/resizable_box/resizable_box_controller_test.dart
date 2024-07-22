import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable_box/resizable_box_controller.dart';

void main() {
  late ResizableBoxController controller;

  late FResizableData top;
  late FResizableData middle;
  late FResizableData bottom;

  late int selectedIndex;
  late int count;
  (FResizableData, FResizableData)? resizeUpdate;
  (FResizableData, FResizableData)? resizeEnd;

  setUp(() {
    selectedIndex = 0;
    count = 0;
    resizeUpdate = null;
    resizeEnd = null;

    top = FResizableData(index: 0, selected: true, constraints: (min: 10, max: 60), offsets: (min: 0, max: 25));
    middle = FResizableData(index: 1, selected: false, constraints: (min: 10, max: 60), offsets: (min: 25, max: 40));
    bottom = FResizableData(index: 2, selected: false, constraints: (min: 10, max: 60), offsets: (min: 40, max: 60));

    controller = ResizableBoxController(
      resizables: [top, middle, bottom],
      axis: Axis.vertical,
      hapticFeedbackVelocity: 0.0,
      onPress: (index) => selectedIndex = index,
      onResizeUpdate: (selected, neighbour) => resizeUpdate = (selected, neighbour),
      onResizeEnd: (selected, neighbour) => resizeEnd = (selected, neighbour),
      interaction: const SelectAndResize(0),
    )..addListener(() => count++);
  });

  for (final (i, (index, direction, offset, topOffsets, middleOffsets, maximized)) in [
    (1, AxisDirection.left, const Offset(-100, 0), (0, 10), (10, 40), false),
    (1, AxisDirection.left, const Offset(100, 0), (0, 30), (30, 40), false),
    //
    (0, AxisDirection.right, const Offset(-100, 0), (0, 10), (10, 40), false),
    (0, AxisDirection.right, const Offset(100, 0), (0, 30), (30, 40), false),
    //
    (1, AxisDirection.up, const Offset(0, -100), (0, 10), (10, 40), false),
    (1, AxisDirection.up, const Offset(0, 100), (0, 30), (30, 40), false),
    //
    (0, AxisDirection.down, const Offset(0, -100), (0, 10), (10, 40), false),
    (0, AxisDirection.down, const Offset(0, 100), (0, 30), (30, 40), false),
  ].indexed) {
    test('[$i] update(...) direction', () {
      expect(controller.update(index, direction, offset), maximized);

      expect(controller.resizables[0].offsets, (min: topOffsets.$1, max: topOffsets.$2));
      expect(controller.resizables[1].offsets, (min: middleOffsets.$1, max: middleOffsets.$2));
      expect(controller.resizables[2].offsets, (min: 40, max: 60));

      expect(count, 1);
      expect(resizeUpdate?.$1.index, index);
      expect(resizeUpdate?.$2.index, index == 1 ? 0 : 1);
    });
  }

  for (final (i, (selected, neighbour, direction)) in [
    (1, 0, AxisDirection.left),
    (1, 0, AxisDirection.left),
    (0, 1, AxisDirection.right),
    (0, 1, AxisDirection.right),
    (1, 0, AxisDirection.up),
    (1, 0, AxisDirection.up),
    (0, 1, AxisDirection.down),
    (0, 1, AxisDirection.down),
  ].indexed) {
    test('[$i] end calls callback', () {
      controller.end(selected, direction);

      expect(resizeEnd?.$1.index, selected);
      expect(resizeEnd?.$2.index, neighbour);
      expect(count, 1);
    });
  }

  test('selected top when interaction is SelectAndResize', () {
    expect(controller.interaction, const SelectAndResize(0));
    expect(selectedIndex, 0);

    expect(controller.select(0), false);

    expect(controller.interaction, const SelectAndResize(0));
    expect(selectedIndex, 0);
    expect(count, 0);

    expect(controller.resizables[0].selected, true);
    expect(controller.resizables[1].selected, false);
    expect(controller.resizables[2].selected, false);
  });

  test('selected bottom when interaction is SelectAndResize', () {
    expect(controller.interaction, const SelectAndResize(0));
    expect(selectedIndex, 0);

    expect(controller.select(2), true);

    expect(controller.interaction, const SelectAndResize(2));
    expect(selectedIndex, 2);
    expect(count, 1);

    expect(controller.resizables[0].selected, false);
    expect(controller.resizables[1].selected, false);
    expect(controller.resizables[2].selected, true);
  });

  test('selected bottom when interaction is Resize', () {
    controller = ResizableBoxController(
      resizables: [top.copyWith(selected: false), middle, bottom],
      axis: Axis.vertical,
      hapticFeedbackVelocity: 0.0,
      onPress: (index) => selectedIndex = index,
      onResizeUpdate: (selected, neighbour) => resizeUpdate = (selected, neighbour),
      onResizeEnd: (selected, neighbour) => resizeEnd = (selected, neighbour),
      interaction: const Resize(),
    )..addListener(() => count++);
    selectedIndex = -1;

    expect(controller.interaction, const Resize());
    expect(selectedIndex, -1);

    expect(controller.select(2), false);

    expect(controller.interaction, const Resize());
    expect(selectedIndex, -1);
    expect(count, 0);

    expect(controller.resizables[0].selected, false);
    expect(controller.resizables[1].selected, false);
    expect(controller.resizables[2].selected, false);
  });
}
