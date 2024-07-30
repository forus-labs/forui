import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/slider.dart';
import 'slider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FResizableController>()])
void main() {
  late MockFResizableController controller;
  late FResizableRegionData data;

  setUp(() {
    data = FResizableRegionData(index: 0, size: (min: 10, max: 100, allRegions: 100), offset: (min: 10, max: 100));
    controller = MockFResizableController();
    when(controller.regions).thenReturn([data]);
  });

  for (final (index, constructor) in [
    () => HorizontalSlider.left(controller: controller, index: -1, size: 500),
    () => HorizontalSlider.right(controller: controller, index: -1, size: 500),
    () => VerticalSlider.up(controller: controller, index: -1, size: 500),
    () => VerticalSlider.down(controller: controller, index: -1, size: 500),
    //
    () => HorizontalSlider.left(controller: controller, index: 1, size: 500),
    () => HorizontalSlider.right(controller: controller, index: 1, size: 500),
    () => VerticalSlider.up(controller: controller, index: 1, size: 500),
    () => VerticalSlider.down(controller: controller, index: 1, size: 500),
  ].indexed) {
    test(
      '[$index] constructor throws error',
      () => expect(constructor, throwsAssertionError),
    );
  }

  for (final (index, (function, direction)) in [
    (() => HorizontalSlider.left(controller: controller, index: 0, size: 50), AxisDirection.left),
    (() => HorizontalSlider.right(controller: controller, index: 0, size: 50), AxisDirection.right),
  ].indexed) {
    group('[$index] horizontal slider', () {
      late HorizontalSlider slider;

      setUp(() => slider = function());

      testWidgets('size', (tester) async {
        await tester.pumpWidget(slider);

        final Size(:height, :width) = tester.getSize(find.byType(SizedBox));
        expect(height, isNot(50));
        expect(width, 50);
      });

      for (final (index, offset) in [
        const Offset(100, 0),
        const Offset(-100, 0),
      ].indexed) {
        testWidgets('[$index] horizontal drag, causes haptic feedback', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verify(controller.update(0, direction, any));
        });

        testWidgets('[$index] horizontal drag, haptic feedback disabled', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verify(controller.update(0, direction, any));
        });
      }

      for (final (index, offset) in [
        const Offset(0, 1000),
        const Offset(0, -1000),
      ].indexed) {
        testWidgets('[$index] vertical drag, causes haptic feedback', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verifyNever(controller.update(0, direction, any));
        });
      }
    });
  }

  for (final (index, (function, direction)) in [
    (() => VerticalSlider.up(controller: controller, index: 0, size: 50), AxisDirection.up),
    (() => VerticalSlider.down(controller: controller, index: 0, size: 50), AxisDirection.down),
  ].indexed) {
    group('[$index] vertical slider', () {
      late VerticalSlider slider;

      setUp(() => slider = function());

      testWidgets('size', (tester) async {
        await tester.pumpWidget(slider);

        final Size(:height, :width) = tester.getSize(find.byType(SizedBox));
        expect(height, 50);
        expect(width, isNot(50));
      });

      for (final (index, offset) in [
        const Offset(0, 1000),
        const Offset(0, -1000),
      ].indexed) {
        testWidgets('[$index] enabled vertical drag', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verify(controller.update(0, direction, any));
        });

        testWidgets('[$index] horizontal drag, causes haptic feedback', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verify(controller.update(0, direction, any));
        });

        testWidgets('[$index] horizontal drag, haptic feedback disabled', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verify(controller.update(0, direction, any));
        });
      }

      for (final (index, offset) in [
        const Offset(100, 0),
        const Offset(-100, 0),
      ].indexed) {
        testWidgets('[$index] horizontal drag', (tester) async {
          when(controller.update(any, any, any)).thenReturn(true);

          await tester.pumpWidget(slider);
          await tester.drag(find.byType(GestureDetector), offset);

          verifyNever(controller.update(0, direction, any));
        });
      }
    });
  }
}
