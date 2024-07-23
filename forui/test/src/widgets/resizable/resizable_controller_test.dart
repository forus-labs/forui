import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/resizable_controller.dart';

void main() {
  late ResizableController controller;

  late FResizableRegionData top;
  late FResizableRegionData middle;
  late FResizableRegionData bottom;

  late int selectedIndex;
  late int count;
  (FResizableRegionData, FResizableRegionData)? resizeUpdate;
  (FResizableRegionData, FResizableRegionData)? resizeEnd;

  setUp(() {
    selectedIndex = 0;
    count = 0;
    resizeUpdate = null;
    resizeEnd = null;

    top = FResizableRegionData(
      index: 0,
      selected: true,
      size: (min: 10, max: 40, allRegions: 60),
      offset: (min: 0, max: 25),
    );
    middle = FResizableRegionData(
      index: 1,
      selected: false,
      size: (min: 10, max: 40, allRegions: 60),
      offset: (min: 25, max: 40),
    );
    bottom = FResizableRegionData(
      index: 2,
      selected: false,
      size: (min: 10, max: 40, allRegions: 60),
      offset: (min: 40, max: 60),
    );

    controller = ResizableController(
      regions: [top, middle, bottom],
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

      expect(
        controller.regions[0].offset,
        (min: topOffsets.$1, max: topOffsets.$2),
      );
      expect(
        controller.regions[1].offset,
        (min: middleOffsets.$1, max: middleOffsets.$2),
      );
      expect(controller.regions[2].offset, (min: 40, max: 60));

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

    expect(controller.regions[0].selected, true);
    expect(controller.regions[1].selected, false);
    expect(controller.regions[2].selected, false);
  });

  test('selected bottom when interaction is SelectAndResize', () {
    expect(controller.interaction, const SelectAndResize(0));
    expect(selectedIndex, 0);

    expect(controller.select(2), true);

    expect(controller.interaction, const SelectAndResize(2));
    expect(selectedIndex, 2);
    expect(count, 1);

    expect(controller.regions[0].selected, false);
    expect(controller.regions[1].selected, false);
    expect(controller.regions[2].selected, true);
  });

  test('selected bottom when interaction is Resize', () {
    controller = ResizableController(
      regions: [top.copyWith(selected: false), middle, bottom],
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

    expect(controller.regions[0].selected, false);
    expect(controller.regions[1].selected, false);
    expect(controller.regions[2].selected, false);
  });
}
