import 'package:flutter/material.dart' hide Thumb;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:forui/src/widgets/slider/track.dart';
import '../../test_scaffold.dart';

void main() {
  group('value slider tooltip', () {
    late Widget slider;

    group('FSliderInteraction.slide', () {
      setUp(() {
        slider = TestScaffold.app(
          data: FThemes.zinc.light,
          // background: background,
          child: FSlider(
            controller: FContinuousSliderController(
              allowedInteraction: FSliderInteraction.slide,
              selection: FSliderSelection(max: 0.75),
            ),
          ),
        );
      });

      testWidgets('long press track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(Track));

        await tester.longPressAt(track.center);
        expect(find.byType(Text), findsNothing);

        await tester.longPressAt(track.centerRight.translate(-50, 0));
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('long press thumb', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.longPress(find.byType(Thumb));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('drag active track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.fling(find.byType(ActiveTrack), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('drag inactive track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(ActiveTrack));
        await tester.flingFrom(track.centerRight.translate(-50, 0), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsOneWidget);
      });
    });

    group('FSliderInteraction.slideThumb', () {
      setUp(() {
        slider = TestScaffold.app(
          data: FThemes.zinc.light,
          // background: background,
          child: FSlider(
            controller: FContinuousSliderController(
              allowedInteraction: FSliderInteraction.slideThumb,
              selection: FSliderSelection(max: 0.75),
            ),
          ),
        );
      });

      testWidgets('long press track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(Track));

        await tester.pumpAndSettle();
        await tester.longPressAt(track.center);
        expect(find.byType(Text), findsNothing);

        await tester.pumpAndSettle();
        await tester.longPressAt(track.centerRight.translate(-50, 0));
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('long press thumb', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.longPress(find.byType(Thumb));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('drag active track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.fling(find.byType(ActiveTrack), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('drag inactive track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(ActiveTrack));
        await tester.flingFrom(track.centerRight.translate(-50, 0), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsNothing);
      });
    });

    group('FSliderInteraction.tap', () {
      setUp(() {
        slider = TestScaffold.app(
          data: FThemes.zinc.light,
          // background: background,
          child: FSlider(
            controller: FContinuousSliderController(
              allowedInteraction: FSliderInteraction.tap,
              selection: FSliderSelection(max: 0.75, extent: (min: 0.70, max: 0.75)),
            ),
          ),
        );
      });

      testWidgets('long press track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(Track));

        await tester.pumpAndSettle();
        await tester.longPressAt(track.center);
        expect(find.byType(Text), findsOneWidget);

        await tester.pumpAndSettle();
        await tester.longPressAt(track.centerRight.translate(-50, 0));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('long press thumb', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.longPress(find.byType(Thumb));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('drag active track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.fling(find.byType(ActiveTrack), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('drag inactive track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(ActiveTrack));
        await tester.flingFrom(track.centerRight.translate(-50, 0), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsNothing);
      });
    });

    group('FSliderInteraction.tapAndSlideThumb', () {
      setUp(() {
        slider = TestScaffold.app(
          data: FThemes.zinc.light,
          // background: background,
          child: FSlider(
            controller: FContinuousSliderController(
              allowedInteraction: FSliderInteraction.tapAndSlideThumb,
              selection: FSliderSelection(max: 0.75, extent: (min: 0.70, max: 0.75)),
            ),
          ),
        );
      });

      testWidgets('long press track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(Track));

        await tester.pumpAndSettle();
        await tester.longPressAt(track.center);
        expect(find.byType(Text), findsOneWidget);

        await tester.pumpAndSettle();
        await tester.longPressAt(track.centerRight.translate(-50, 0));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('long press thumb', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.longPress(find.byType(Thumb));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('drag active track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        await tester.fling(find.byType(ActiveTrack), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('drag inactive track', (tester) async {
        await tester.pumpWidget(slider);
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(ActiveTrack));
        await tester.flingFrom(track.centerRight.translate(-50, 0), const Offset(-300, 0), 10);
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(Text), findsNothing);
      });
    });
  });

  for (final layout in Layout.values) {
    group('continuous value selection - $layout', () {
      late FContinuousSliderController controller;
      late Widget slider;

      group('FSliderInteraction.slide', () {
        setUp(() {
          controller = FContinuousSliderController(
            allowedInteraction: FSliderInteraction.slide,
            selection: FSliderSelection(max: 0.75, extent: (min: 0.5, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
            ),
          );
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, greaterThan(0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, lessThan(0.75));
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });
      });

      group('FSliderInteraction.slideThumb', () {
        setUp(() {
          controller = FContinuousSliderController(
            allowedInteraction: FSliderInteraction.slideThumb,
            selection: FSliderSelection(max: 0.75, extent: (min: 0.5, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
            ),
          );
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, greaterThan(0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, lessThan(0.75));
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });
      });

      group('FSliderInteraction.tap', () {
        setUp(() {
          controller = FContinuousSliderController(
            allowedInteraction: FSliderInteraction.tap,
            selection: FSliderSelection(max: 0.75, extent: (min: 0.5, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
            ),
          );
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          // Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          /// Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));
        });
      });

      group('FSliderInteraction.tapAndSlideThumb', () {
        setUp(() {
          controller = FContinuousSliderController(
            allowedInteraction: FSliderInteraction.tapAndSlideThumb,
            selection: FSliderSelection(max: 0.75, extent: (min: 0.5, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
            ),
          );
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, greaterThan(0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, lessThan(0.75));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          // Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          /// Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.8));
        });
      });
    });

    group('continuous range selection - $layout', () {
      late FContinuousSliderController controller;
      late Widget slider;

      setUp(() {
        controller = FContinuousSliderController.range(
          selection: FSliderSelection(min: 0.25, max: 0.75, extent: (min: 0.3, max: 0.8)),
        );

        slider = TestScaffold.app(
          data: FThemes.zinc.light,
          // background: background,
          child: FSlider(
            layout: layout,
            controller: controller,
          ),
        );
      });

      testWidgets('tap active track', (tester) async {
        await tester.pumpWidget(slider);

        final track = tester.getRect(find.byType(ActiveTrack));

        await tester.tapAt(track.center);
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));
      });

      testWidgets('tap inactive track', (tester) async {
        await tester.pumpWidget(slider);

        final track = tester.getRect(find.byType(ActiveTrack));

        await tester.tapAt(track.min(layout) + layout.directional(-50));
        await tester.pumpAndSettle();
        expect(controller.selection.offset.min, lessThan(0.25));
        expect(controller.selection.offset.max, 0.75);

        await tester.tapAt(track.max(layout) + layout.directional(50));
        await tester.pumpAndSettle();
        expect(controller.selection.offset.min, lessThan(0.25));
        expect(controller.selection.offset.max, greaterThan(0.75));
      });

      testWidgets('drag thumbs', (tester) async {
        await tester.pumpWidget(slider);

        await tester.drag(find.byType(Thumb).first, layout.directional(100));
        await tester.pumpAndSettle();
        expect(controller.selection.offset.min, greaterThan(0.25));
        expect(controller.selection.offset.max, 0.75);

        await tester.drag(find.byType(Thumb).first, layout.directional(-200));
        await tester.pumpAndSettle();
        expect(controller.selection.offset.min, lessThan(0.25));
        expect(controller.selection.offset.max, 0.75);

        await tester.drag(find.byType(Thumb).last, layout.directional(100));
        await tester.pumpAndSettle();
        expect(controller.selection.offset.min, lessThan(0.25));
        expect(controller.selection.offset.max, greaterThan(0.75));

        await tester.drag(find.byType(Thumb).last, layout.directional(-200));
        await tester.pumpAndSettle();
        expect(controller.selection.offset.min, lessThan(0.25));
        expect(controller.selection.offset.max, lessThan(0.75));
      });

      testWidgets('drag active track', (tester) async {
        await tester.pumpWidget(slider);

        await tester.drag(find.byType(ActiveTrack), layout.directional(500));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));

        await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));
      });
    });

    group('discrete value selection - $layout', () {
      late FDiscreteSliderController controller;
      late Widget slider;

      group('FSliderInteraction.slide', () {
        setUp(() {
          controller = FDiscreteSliderController(
            allowedInteraction: FSliderInteraction.slide,
            selection: FSliderSelection(max: 0.5, extent: (min: 0.5, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
              marks: const [
                FSliderMark(value: 0),
                FSliderMark(value: 0.25),
                FSliderMark(value: 0.5),
                FSliderMark(value: 0.75),
                FSliderMark(value: 1),
              ],
            ),
          );
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });
      });

      group('FSliderInteraction.slideThumb', () {
        setUp(() {
          controller = FDiscreteSliderController(
            allowedInteraction: FSliderInteraction.slideThumb,
            selection: FSliderSelection(max: 0.5, extent: (min: 0.5, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
              marks: const [
                FSliderMark(value: 0),
                FSliderMark(value: 0.25),
                FSliderMark(value: 0.5),
                FSliderMark(value: 0.75),
                FSliderMark(value: 1),
              ],
            ),
          );
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });
      });

      group('FSliderInteraction.tap', () {
        setUp(() {
          controller = FDiscreteSliderController(
            allowedInteraction: FSliderInteraction.tap,
            selection: FSliderSelection(max: 0.5, extent: (min: 0.25, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
              marks: const [
                FSliderMark(value: 0),
                FSliderMark(value: 0.25),
                FSliderMark(value: 0.5),
                FSliderMark(value: 0.75),
                FSliderMark(value: 1),
              ],
            ),
          );
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.25));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          // Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.25));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.25));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          /// Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });
      });

      group('FSliderInteraction.tapAndSlideThumb', () {
        setUp(() {
          controller = FDiscreteSliderController(
            allowedInteraction: FSliderInteraction.tapAndSlideThumb,
            selection: FSliderSelection(max: 0.5, extent: (min: 0.25, max: 0.8)),
          );

          slider = TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              layout: layout,
              controller: controller,
              marks: const [
                FSliderMark(value: 0),
                FSliderMark(value: 0.25),
                FSliderMark(value: 0.5),
                FSliderMark(value: 0.75),
                FSliderMark(value: 1),
              ],
            ),
          );
        });


        testWidgets('tap track', (tester) async {
          await tester.pumpWidget(slider);

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.25));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        testWidgets('drag thumb', (tester) async {
          await tester.pumpWidget(slider);

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.75));

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });

        testWidgets('drag active track', (tester) async {
          await tester.pumpWidget(slider);

          // Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.25));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.25));
        });

        testWidgets('drag inactive track', (tester) async {
          await tester.pumpWidget(slider);

          /// Drag gestures will cause the active track to shrink since they are composed of tap + drag events.
          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: 0.5));
        });
      });
    });

    group('discrete range selection - $layout', () {
      late FDiscreteSliderController controller;
      late Widget slider;

      setUp(() {
        controller = FDiscreteSliderController.range(
          selection: FSliderSelection(min: 0.25, max: 0.75),
        );

        slider = TestScaffold.app(
          data: FThemes.zinc.light,
          // background: background,
          child: FSlider(
            layout: layout,
            controller: controller,
            marks: const [
              FSliderMark(value: 0),
              FSliderMark(value: 0.25),
              FSliderMark(value: 0.5),
              FSliderMark(value: 0.75),
              FSliderMark(value: 1),
            ],
          ),
        );
      });

      testWidgets('tap active track', (tester) async {
        await tester.pumpWidget(slider);

        final track = tester.getRect(find.byType(ActiveTrack));

        await tester.tapAt(track.center);
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));
      });

      testWidgets('tap inactive track', (tester) async {
        await tester.pumpWidget(slider);

        final track = tester.getRect(find.byType(ActiveTrack));

        await tester.tapAt(track.min(layout) + layout.directional(-100));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0, max: 0.75));

        await tester.tapAt(track.max(layout) + layout.directional(100));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0, max: 1));
      });

      testWidgets('drag thumbs', (tester) async {
        await tester.pumpWidget(slider);

        await tester.drag(find.byType(Thumb).first, layout.directional(100));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.5, max: 0.75));

        await tester.drag(find.byType(Thumb).first, layout.directional(-200));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));

        await tester.drag(find.byType(Thumb).last, layout.directional(100));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 1));

        await tester.drag(find.byType(Thumb).last, layout.directional(-200));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));
      });

      testWidgets('drag active track', (tester) async {
        await tester.pumpWidget(slider);

        await tester.drag(find.byType(ActiveTrack), layout.directional(500));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));

        await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
        await tester.pumpAndSettle();
        expect(controller.selection.offset, (min: 0.25, max: 0.75));
      });
    });
  }
}

extension on Rect {
  Offset min(Layout layout) => switch (layout) {
        Layout.ltr => centerLeft,
        Layout.rtl => centerRight,
        Layout.ttb => topCenter,
        Layout.btt => bottomCenter,
      };

  Offset max(Layout layout) => switch (layout) {
        Layout.ltr => centerRight,
        Layout.rtl => centerLeft,
        Layout.ttb => bottomCenter,
        Layout.btt => topCenter,
      };
}

extension on Layout {
  Offset directional(double value) => switch (this) {
        Layout.ltr => Offset(value, 0),
        Layout.rtl => Offset(-value, 0),
        Layout.ttb => Offset(0, value),
        Layout.btt => Offset(0, -value),
      };
}
