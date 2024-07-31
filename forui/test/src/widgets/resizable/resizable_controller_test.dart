import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:sugar/collection.dart';

void main() {
  late FResizableController controller;

  late FResizableRegionData top;
  late FResizableRegionData middle;
  late FResizableRegionData bottom;

  late int count;
  List<FResizableRegionData>? resizeUpdate;
  List<FResizableRegionData>? resizeEnd;

  setUp(() {
    count = 0;
    resizeUpdate = null;
    resizeEnd = null;

    top = FResizableRegionData(index: 0, extent: (min: 10, max: 40, total: 60), offset: (min: 0, max: 25));
    middle = FResizableRegionData(index: 1, extent: (min: 10, max: 40, total: 60), offset: (min: 25, max: 40));
    bottom = FResizableRegionData(index: 2, extent: (min: 10, max: 40, total: 60), offset: (min: 40, max: 60));
  });

  group('_ResizableController', () {
    setUp(() {
      controller = FResizableController(
        onResizeUpdate: (regions) => resizeUpdate = regions,
        onResizeEnd: (regions) => resizeEnd = regions,
      )
        ..addListener(() => count++)
        ..regions.addAll([top, middle, bottom]);
    });

    for (final (i, (offset, topOffsets, middleOffsets, maximized)) in [
      (-100.0, (0, 10), (10, 40), false),
      (100.0, (0, 30), (30, 40), false),
    ].indexed) {
      test('[$i] update(...) direction', () {
        expect(controller.update(0, 1, offset), maximized);

        expect(controller.regions[0].offset, (min: topOffsets.$1, max: topOffsets.$2));
        expect(controller.regions[1].offset, (min: middleOffsets.$1, max: middleOffsets.$2));
        expect(controller.regions[2].offset, (min: 40, max: 60));

        expect(count, 1);
        expect(resizeUpdate?.length, 2);
        expect(resizeUpdate?[0].index == resizeUpdate?[1].index, false);
        expect(resizeUpdate?[0].index, anyOf(0, 1));
        expect(resizeUpdate?[1].index, anyOf(0, 1));
      });
    }

    test('end(...) calls callback', () {
      controller.end(0, 1);

      expect(count, 0);
      expect(resizeEnd?.length, 2);
      expect(resizeEnd?.associate(by: (e) => e.index).length, 2);
      expect(resizeEnd?[0].index, anyOf(0, 1));
      expect(resizeEnd?[0].index, anyOf(0, 1));
    });
  });

  group('_CascadeController', () {
    setUp(() {
      controller = FResizableController.cascade(
        onResizeUpdate: (regions) => resizeUpdate = regions,
        onResizeEnd: (regions) => resizeEnd = regions,
      )
        ..addListener(() => count++)
        ..regions.addAll([top, middle, bottom]);
    });

    for (final (i, (offset, topOffset, middleOffset, bottomOffset, length)) in [
      (-100.0, (0, 10), (10, 40), (40, 60), 2),
      (100.0, (0, 40), (40, 50), (50, 60), 3),
      (1.0, (0, 27), (27, 40), (40, 60), 2),
    ].indexed) {
      test('[$i] update(...) direction', () {
        controller
          ..update(0, 1, offset)
          ..update(0, 1, offset);

        expect(controller.regions[0].offset, (min: topOffset.$1, max: topOffset.$2));
        expect(controller.regions[1].offset, (min: middleOffset.$1, max: middleOffset.$2));
        expect(controller.regions[2].offset, (min: bottomOffset.$1, max: bottomOffset.$2));

        expect(count, anyOf(1, 2));
        expect(resizeUpdate?.associate(by: (e) => e.index).length, length);
      });
    }

    test('end(...) calls callback', () {
      controller.end(0, 1);

      expect(count, 0);
      expect(resizeEnd?.length, 3);
      expect(resizeEnd?.associate(by: (e) => e.index).length, 3);
      expect(resizeEnd?[0].index, anyOf(0, 1));
      expect(resizeEnd?[0].index, anyOf(0, 1));
    });
  });
}
