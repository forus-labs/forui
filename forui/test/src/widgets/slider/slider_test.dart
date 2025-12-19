import 'package:flutter/material.dart' hide Thumb;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:forui/src/widgets/slider/track.dart';
import '../../test_scaffold.dart';

void main() {
  group('managed', () {
    for (final (name, control) in [
      ('continuous', (ValueChanged<FSliderValue>? c) => FSliderControl.managedContinuous(onChange: c)),
      ('continuous-range', (ValueChanged<FSliderValue>? c) => FSliderControl.managedContinuousRange(onChange: c)),
      ('discrete', (ValueChanged<FSliderValue>? c) => FSliderControl.managedDiscrete(onChange: c)),
      ('discrete-range', (ValueChanged<FSliderValue>? c) => FSliderControl.managedDiscreteRange(onChange: c)),
    ]) {
      testWidgets('$name - updates and calls onChange', (tester) async {
        FSliderValue? changed;

        await tester.pumpWidget(
          TestScaffold.app(
            child: FSlider(
              control: control((v) => changed = v),
              marks: const [.mark(value: 0), .mark(value: 0.5), .mark(value: 1)],
            ),
          ),
        );

        final track = tester.getRect(find.byType(Track));
        await tester.tapAt(track.centerRight.translate(-10, 0));
        await tester.pumpAndSettle();

        expect(changed, isNotNull);
        expect(changed!.max, greaterThan(0));
      });
    }
  });

  group('value slider tooltip', () {
    Widget slider({FSliderValue? value, FSliderInteraction interaction = .tapAndSlideThumb}) => TestScaffold.app(
      child: FSlider(
        control: .managedContinuous(initial: value ?? FSliderValue(max: 0.75), interaction: interaction),
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
    Widget slider({FSliderValue? value}) => TestScaffold.app(
      theme: FThemes.zinc.light,
      child: FSlider(control: .managedContinuousRange(initial: value ?? FSliderValue(max: 0.75))),
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
      await tester.pumpWidget(slider(value: FSliderValue(max: 0.25)));

      await tester.press(find.byType(Track));
      expect(find.byType(Text), findsNothing);
    });
  });

  for (final layout in FLayout.values) {
    Widget slider(FSliderController controller) => TestScaffold.app(
      padded: false,
      child: FSlider(
        layout: layout,
        control: controller is FContinuousSliderController
            ? .managedContinuous(controller: autoDispose(controller))
            : .managedDiscrete(controller: autoDispose(controller as FDiscreteSliderController)),
        marks: const [.mark(value: 0), .mark(value: 0.25), .mark(value: 0.5), .mark(value: 0.75), .mark(value: 1)],
      ),
    );

    group('value selection - $layout', () {
      FSliderController continuous(FSliderInteraction interaction) => FContinuousSliderController(
        interaction: interaction,
        value: FSliderValue(max: 0.75, constraints: (min: 0.5, max: 0.8)),
      );

      FSliderController discrete(FSliderInteraction interaction) => FDiscreteSliderController(
        interaction: interaction,
        value: FSliderValue(max: 0.5, constraints: (min: 0.25, max: 0.8)),
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
          expect(controller.value.min, 0);
          expect(controller.value.max, expandExpected);

          await tester.drag(find.byType(Thumb), layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.value.min, 0);
          expect(controller.value.max, shrinkExpected);
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
          expect((controller.value.min, controller.value.max), (0, shrinkExpected));

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect((controller.value.min, controller.value.max), (0, expandExpected));
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
          expect((controller.value.min, controller.value.max), (0, expandExpected));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect((controller.value.min, controller.value.max), (0, shrinkExpected));
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
          expect((controller.value.min, controller.value.max), (0, expandExpected));

          await tester.dragFrom(
            tester.getRect(find.byType(ActiveTrack)).max(layout) + layout.directional(50),
            layout.directional(-500),
          );
          await tester.pumpAndSettle();
          expect((controller.value.min, controller.value.max), (0, shrinkExpected));
        });
      }
    });

    group('range selection - $layout', () {
      FContinuousSliderController continuous() =>
          .range(value: FSliderValue(min: 0.25, max: 0.75, constraints: (min: 0.3, max: 0.8)));

      FDiscreteSliderController discrete() => .range(value: FSliderValue(min: 0.25, max: 0.75));

      for (final (index, constructor) in [continuous, discrete].indexed) {
        testWidgets('tap active track - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.center);
          await tester.pumpAndSettle();
          expect((controller.value.min, controller.value.max), (0.25, 0.75));
        });
      }

      for (final (index, (constructor, minExpected, maxExpected)) in [
        (continuous, lessThan(0.25), greaterThan(0.75)),
        (discrete, 0, 1),
      ].indexed) {
        testWidgets('tap inactive track - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          final track = tester.getRect(find.byType(ActiveTrack));

          await tester.tapAt(track.min(layout) + layout.directional(-100));
          await tester.pumpAndSettle();
          expect(controller.value.min, minExpected);
          expect(controller.value.max, 0.75);

          await tester.tapAt(track.max(layout) + layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.value.min, minExpected);
          expect(controller.value.max, maxExpected);
        });
      }

      for (final (index, (constructor, minShrink, minExpand, maxExpand, maxShrink)) in [
        (continuous, greaterThan(0.25), lessThan(0.25), greaterThan(0.75), lessThan(0.75)),
        (discrete, 0.5, 0.25, 1, 0.75),
      ].indexed) {
        testWidgets('drag thumbs - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          await tester.drag(find.byType(Thumb).first, layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.value.min, minShrink);
          expect(controller.value.max, 0.75);

          await tester.drag(find.byType(Thumb).first, layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.value.min, minExpand);
          expect(controller.value.max, 0.75);

          await tester.drag(find.byType(Thumb).last, layout.directional(100));
          await tester.pumpAndSettle();
          expect(controller.value.min, minExpand);
          expect(controller.value.max, maxExpand);

          await tester.drag(find.byType(Thumb).last, layout.directional(-200));
          await tester.pumpAndSettle();
          expect(controller.value.min, minExpand);
          expect(controller.value.max, maxShrink);
        });
      }

      for (final (index, constructor) in [continuous, discrete].indexed) {
        testWidgets('drag active track - $index', (tester) async {
          final controller = constructor();
          await tester.pumpWidget(slider(controller));

          await tester.drag(find.byType(ActiveTrack), layout.directional(500));
          await tester.pumpAndSettle();
          expect((controller.value.min, controller.value.max), (0.25, 0.75));

          await tester.drag(find.byType(ActiveTrack), layout.directional(-500));
          await tester.pumpAndSettle();
          expect((controller.value.min, controller.value.max), (0.25, 0.75));
        });
      }
    });
  }
}

extension on Rect {
  Offset min(FLayout layout) => switch (layout) {
    .ltr => centerLeft,
    .rtl => centerRight,
    .ttb => topCenter,
    .btt => bottomCenter,
  };

  Offset max(FLayout layout) => switch (layout) {
    .ltr => centerRight,
    .rtl => centerLeft,
    .ttb => bottomCenter,
    .btt => topCenter,
  };
}

extension on FLayout {
  Offset directional(double value) => switch (this) {
    .ltr => Offset(value, 0),
    .rtl => Offset(-value, 0),
    .ttb => Offset(0, value),
    .btt => Offset(0, -value),
  };
}
