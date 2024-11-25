// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

// Project imports:
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFContinuousSliderController', (tester) async {
    late FContinuousSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFContinuousSliderController(selection: FSliderSelection(max: 0.2));
          return FSlider(
            controller: controller,
          );
        }),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });

  testWidgets('useFContinuousRangeSliderController', (tester) async {
    late FContinuousSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFContinuousRangeSliderController(selection: FSliderSelection(max: 0.2));
          return FSlider(
            controller: controller,
          );
        }),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });

  testWidgets('useFDiscreteSliderController', (tester) async {
    late FDiscreteSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFDiscreteSliderController(selection: FSliderSelection(max: 0.2));
          return FSlider(
            controller: controller,
            marks: const [
              FSliderMark(value: 0),
              FSliderMark(value: 0.2),
              FSliderMark(value: 0.5),
            ],
          );
        }),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });

  testWidgets('useFDiscreteRangeSliderController', (tester) async {
    late FDiscreteSliderController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFDiscreteRangeSliderController(selection: FSliderSelection(max: 0.2));
          return FSlider(
            controller: controller,
            marks: const [
              FSliderMark(value: 0),
              FSliderMark(value: 0.2),
              FSliderMark(value: 0.5),
            ],
          );
        }),
      ),
    );

    await tester.tapAt(tester.getCenter(find.byType(FSlider)));

    await tester.pumpAndSettle();
  });
}
