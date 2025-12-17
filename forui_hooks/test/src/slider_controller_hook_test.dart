import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFContinuousSliderController', (tester) async {
    late FContinuousSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFContinuousSliderController(value: FSliderValue(max: 0.2));
            return FSlider(control: .managedContinuous(controller: controller),);
          },
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });

  testWidgets('useFContinuousRangeSliderController', (tester) async {
    late FContinuousSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFContinuousRangeSliderController(value: FSliderValue(max: 0.2));
            return FSlider(control: .managedContinuousRange(controller: controller));
          },
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });

  testWidgets('useFDiscreteSliderController', (tester) async {
    late FDiscreteSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFDiscreteSliderController(value: FSliderValue(max: 0.2));
            return FSlider(
              control: .managedDiscrete(controller: controller),
              marks: const [FSliderMark(value: 0), FSliderMark(value: 0.2), FSliderMark(value: 0.5)],
            );
          },
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });

  testWidgets('useFDiscreteRangeSliderController', (tester) async {
    late FDiscreteSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFDiscreteRangeSliderController(value: FSliderValue(max: 0.2));
            return FSlider(
              control: .managedDiscreteRange(controller: controller),
              marks: const [FSliderMark(value: 0), FSliderMark(value: 0.2), FSliderMark(value: 0.5)],
            );
          },
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });
}
