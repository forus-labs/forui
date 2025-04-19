// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart' hide Thumb;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:forui/src/widgets/slider/track.dart';
import '../../test_scaffold.dart';

void main() {
  group('state', () {
    testWidgets('set initial value', (tester) async {
      final key = GlobalKey<FormState>();

      FSliderSelection? initial;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FSlider(
              controller: autoDispose(FContinuousSliderController(selection: FSliderSelection(max: 0.5))),
              onSaved: (value) => initial = value,
            ),
          ),
        ),
      );

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial?.offset, (max: 0.5, min: 0.0));
    });

    testWidgets('update controller', (tester) async {
      final first = autoDispose(FContinuousSliderController(selection: FSliderSelection(max: 0.5)));
      await tester.pumpWidget(TestScaffold(child: FSlider(controller: first)));

      expect(first.hasListeners, true);
      expect(first.disposed, false);

      final second = autoDispose(FContinuousSliderController(selection: FSliderSelection(max: 0.5)));
      await tester.pumpWidget(TestScaffold(child: FSlider(controller: second)));

      expect(first.hasListeners, false);
      expect(first.disposed, false);
      expect(second.hasListeners, true);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FContinuousSliderController(selection: FSliderSelection(max: 0.5)));
      await tester.pumpWidget(TestScaffold(child: FSlider(controller: controller)));

      expect(controller.hasListeners, true);
      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);
    });
  });

  group('value slider tooltip', () {
    Widget slider({
      FSliderSelection? selection,
      FSliderInteraction interaction = FSliderInteraction.tapAndSlideThumb,
    }) => TestScaffold.app(
      child: FSlider(
        controller: autoDispose(
          FContinuousSliderController(
            selection: selection ?? FSliderSelection(max: 0.75),
            allowedInteraction: interaction,
          ),
        ),
      ),
    );

    for (final (interaction, expected) in [
      (FSliderInteraction.slide, findsNothing),
      (FSliderInteraction.slideThumb, findsNothing),
      (FSliderInteraction.tap, findsOneWidget),
      (FSliderInteraction.tapAndSlideThumb, findsOneWidget),
    ]) {
      testWidgets('long press track - $interaction', (tester) async {
        await tester.pumpWidget(slider(interaction: interaction));
        expect(find.byType(Text), findsNothing);

        final track = tester.getRect(find.byType(Track));

        await tester.longPressAt(track.center);
        expect(find.byType(Text), expected);

        await tester.longPressAt(track.centerRight.translate(-50, 0));
        expect(find.byType(Text), expected);
      });
    }

    for (final interaction in FSliderInteraction.values) {
      testWidgets('long press thumb - $interaction', (tester) async {
        await tester.pumpWidget(slider(interaction: interaction));
        expect(find.byType(Text), findsNothing);

        await tester.longPress(find.byType(Thumb));
        expect(find.byType(Text), findsOneWidget);
      });
    }

    group('drag track', () {
      for (final (interaction, expected) in [
        (FSliderInteraction.slide, findsOneWidget),
        (FSliderInteraction.slideThumb, findsOneWidget),
        (FSliderInteraction.tap, findsOneWidget),
        (FSliderInteraction.tapAndSlideThumb, findsOneWidget),
      ]) {
        testWidgets('drag active track - $interaction', (tester) async {
          await tester.pumpWidget(slider(interaction: interaction));
          expect(find.byType(Text), findsNothing);

          await tester.fling(find.byType(ActiveTrack), const Offset(-300, 0), 10);
          await tester.pump();
          expect(find.byType(Text), expected);
        });

        testWidgets('drag inactive track - $interaction', (tester) async {
          await tester.pumpWidget(slider(interaction: interaction));
          expect(find.byType(Text), findsNothing);

          final track = tester.getRect(find.byType(ActiveTrack));
          await tester.flingFrom(track.centerRight.translate(-50, 0), const Offset(-300, 0), 10);
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(Text), expected);
        });
      }
    });
  });

  group('range slider tooltip', () {
    Widget slider({FSliderSelection? selection}) => TestScaffold.app(
      theme: FThemes.zinc.light,
      child: FSlider(
        controller: autoDispose(FContinuousSliderController.range(selection: selection ?? FSliderSelection(max: 0.75))),
      ),
    );

    testWidgets('long press thumb', (tester) async {
      await tester.pumpWidget(slider());

      await tester.longPress(find.byType(Thumb).first);
      expect(find.byType(Text), findsOneWidget);

      await tester.longPress(find.byType(Thumb).last);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('press active track', (tester) async {
      await tester.pumpWidget(slider());

      await tester.press(find.byType(ActiveTrack));
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('press inactive track', (tester) async {
      await tester.pumpWidget(slider(selection: FSliderSelection(max: 0.25)));

      await tester.press(find.byType(Track));
      expect(find.byType(Text), findsNothing);
    });
  });

  for (final layout in FLayout.values) {
    Widget slider(FSliderController controller) => TestScaffold.app(
      padded: false,
      child: FSlider(
        layout: layout,
        controller: autoDispose(controller),
        marks: const [
          FSliderMark(value: 0),
          FSliderMark(value: 0.25),
          FSliderMark(value: 0.5),
          FSliderMark(value: 0.75),
          FSliderMark(value: 1),
        ],
      ),
    );

    group('value selection - $layout', () {
      FSliderController continuous(FSliderInteraction interaction) => FContinuousSliderController(
        allowedInteraction: interaction,
        selection: FSliderSelection(max: 0.75, extent: (min: 0.5, max: 0.8)),
      );

      FSliderController discrete(FSliderInteraction interaction) => FDiscreteSliderController(
        allowedInteraction: interaction,
        selection: FSliderSelection(max: 0.5, extent: (min: 0.25, max: 0.8)),
      );

      for (final (con, interaction, expandExpected, shrinkExpected) in [
        (true, FSliderInteraction.slide, greaterThan(0.75), lessThan(0.75)),
        (true, FSliderInteraction.slideThumb, greaterThan(0.75), lessThan(0.75)),
        (true, FSliderInteraction.tap, 0.75, 0.75),
        (true, FSliderInteraction.tapAndSlideThumb, greaterThan(0.75), lessThan(0.75)),
        (false, FSliderInteraction.slide, 0.75, 0.5),
        (false, FSliderInteraction.slideThumb, 0.75, 0.5),
        (false, FSliderInteraction.tap, 0.5, 0.5),
        (false, FSliderInteraction.tapAndSlideThumb, 0.75, 0.5),
      ]) {
        testWidgets('drag thumb - ${con ? 'continuous' : 'discrete'} - $interaction', (tester) async {
          final controller = con ? continuous(interaction) : discrete(interaction);
          await tester.pumpWidget(slider(controller));

          await tester.drag(find.byType(Thumb), layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, expandExpected);

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, 0);
          expect(controller.selection.offset.max, shrinkExpected);
        });
      }

      for (final (con, interaction, shrinkExpected, expandExpected) in [
        (true, FSliderInteraction.slide, 0.75, 0.75),
        (true, FSliderInteraction.slideThumb, 0.75, 0.75),
        (true, FSliderInteraction.tap, 0.5, 0.8),
        (true, FSliderInteraction.tapAndSlideThumb, 0.5, 0.8),
        (false, FSliderInteraction.slide, 0.5, 0.5),
        (false, FSliderInteraction.slideThumb, 0.5, 0.5),
        (false, FSliderInteraction.tap, 0.25, 0.75),
        (false, FSliderInteraction.tapAndSlideThumb, 0.25, 0.75),
      ]) {
        testWidgets('tap track - ${con ? 'continuous' : 'discrete'} - $interaction', (tester) async {
          final controller = con ? continuous(interaction) : discrete(interaction);
          await tester.pumpWidget(slider(controller));

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: shrinkExpected));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: expandExpected));
        });
      }

      for (final (con, interaction, expandExpected, shrinkExpected) in [
        (true, FSliderInteraction.slide, 0.8, 0.5),
        (true, FSliderInteraction.slideThumb, 0.75, 0.75),
        (true, FSliderInteraction.tap, 0.75, 0.75),
        (true, FSliderInteraction.tapAndSlideThumb, 0.75, 0.75),
        (false, FSliderInteraction.slide, 0.75, 0.25),
        (false, FSliderInteraction.slideThumb, 0.5, 0.5),
        (false, FSliderInteraction.tap, 0.5, 0.5),
        (false, FSliderInteraction.tapAndSlideThumb, 0.5, 0.5),
      ]) {
        testWidgets('drag active track - ${con ? 'continuous' : 'discrete'} - $interaction', (tester) async {
          final controller = con ? continuous(interaction) : discrete(interaction);
          await tester.pumpWidget(slider(controller));

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: expandExpected));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: shrinkExpected));
        });
      }

      for (final (con, interaction, expandExpected, shrinkExpected) in [
        (true, FSliderInteraction.slide, 0.8, 0.5),
        (true, FSliderInteraction.slideThumb, 0.75, 0.75),
        (true, FSliderInteraction.tap, 0.75, 0.75),
        (true, FSliderInteraction.tapAndSlideThumb, 0.75, 0.75),
        (false, FSliderInteraction.slide, 0.75, 0.25),
        (false, FSliderInteraction.slideThumb, 0.5, 0.5),
        (false, FSliderInteraction.tap, 0.5, 0.5),
        (false, FSliderInteraction.tapAndSlideThumb, 0.5, 0.5),
      ]) {
        testWidgets('drag inactive track - ${con ? 'continuous' : 'discrete'} - $interaction', (tester) async {
          final controller = con ? continuous(interaction) : discrete(interaction);
          await tester.pumpWidget(slider(controller));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: expandExpected));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0, max: shrinkExpected));
        });
      }
    });

    group('range selection - $layout', () {
      FSliderController continuous() => FContinuousSliderController.range(
        selection: FSliderSelection(min: 0.25, max: 0.75, extent: (min: 0.3, max: 0.8)),
      );

      FSliderController discrete() =>
          FDiscreteSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75));

      for (final (index, constructor) in [continuous, discrete].indexed) {
        testWidgets('tap active track - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0.25, max: 0.75));
        });
      }

      for (final (index, (constructor, minExpected, maxExpected))
          in [(continuous, lessThan(0.25), greaterThan(0.75)), (discrete, 0, 1)].indexed) {
        testWidgets('tap inactive track - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.min(layout) + layout.directional(-100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, minExpected);
          expect(controller.selection.offset.max, 0.75);

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, minExpected);
          expect(controller.selection.offset.max, maxExpected);
        });
      }

      for (final (index, (constructor, minShrink, minExpand, maxExpand, maxShrink))
          in [
            (continuous, greaterThan(0.25), lessThan(0.25), greaterThan(0.75), lessThan(0.75)),
            (discrete, 0.5, 0.25, 1, 0.75),
          ].indexed) {
        testWidgets('drag thumbs - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          await tester.drag(find.byType(Thumb).first, layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, minShrink);
          expect(controller.selection.offset.max, 0.75);

          await tester.drag(find.byType(Thumb).first, layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, minExpand);
          expect(controller.selection.offset.max, 0.75);

          await tester.drag(find.byType(Thumb).last, layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, minExpand);
          expect(controller.selection.offset.max, maxExpand);

          await tester.drag(find.byType(Thumb).last, layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.selection.offset.min, minExpand);
          expect(controller.selection.offset.max, maxShrink);
        });
      }

      for (final (index, constructor) in [continuous, discrete].indexed) {
        testWidgets('drag active track - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0.25, max: 0.75));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect(controller.selection.offset, (min: 0.25, max: 0.75));
        });
      }
    });
  }
}

extension on Rect {
  Offset min(FLayout layout) => switch (layout) {
    FLayout.ltr => centerLeft,
    FLayout.rtl => centerRight,
    FLayout.ttb => topCenter,
    FLayout.btt => bottomCenter,
  };

  Offset max(FLayout layout) => switch (layout) {
    FLayout.ltr => centerRight,
    FLayout.rtl => centerLeft,
    FLayout.ttb => bottomCenter,
    FLayout.btt => topCenter,
  };
}

extension on FLayout {
  Offset directional(double value) => switch (this) {
    FLayout.ltr => Offset(value, 0),
    FLayout.rtl => Offset(-value, 0),
    FLayout.ttb => Offset(0, value),
    FLayout.btt => Offset(0, -value),
  };
}
