@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Thumb;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSlider', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final layout in Layout.values) {
        for (final enabled in [true, false]) {
          testWidgets('$name - $layout - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
            await tester.pumpWidget(
              TestScaffold.app(
                data: theme,
                // background: background,
                child: FSlider(
                  controller: FContinuousSliderController.range(selection: FSliderSelection(min: 0.30, max: 0.60)),
                  layout: layout,
                  enabled: enabled,
                  marks: const [
                    FSliderMark(value: 0.0, label: Text('0')),
                    FSliderMark(value: 0.25, label: Text('25'), tick: false),
                    FSliderMark(value: 0.5, label: Text('50')),
                    FSliderMark(value: 0.75, label: Text('75'), tick: false),
                    FSliderMark(value: 1.0, label: Text('100')),
                  ],
                ),
              ),
            );

            final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
            await gesture.addPointer(location: Offset.zero);
            addTearDown(gesture.removePointer);
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.byType(Thumb).first));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('slider/range-slider-$name-$layout-${enabled ? 'enabled' : 'disabled'}.png'),
            );
          });
        }
      }
    }

    for (final layout in Layout.values) {
      for (final min in [true, false]) {
        testWidgets('single value - $layout - ${min ? 'min' : 'max'}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              data: FThemes.zinc.light,
              // background: background,
              child: FSlider(
                controller: FContinuousSliderController(
                  minExtendable: min,
                  selection: FSliderSelection(min: 0.30, max: 0.60),
                ),
                layout: layout,
                marks: const [
                  FSliderMark(value: 0.0, label: Text('0')),
                  FSliderMark(value: 0.25, label: Text('25'), tick: false),
                  FSliderMark(value: 0.5, label: Text('50')),
                  FSliderMark(value: 0.75, label: Text('75'), tick: false),
                  FSliderMark(value: 1.0, label: Text('100')),
                ],
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.byType(Thumb).first));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('slider/value-slider-$layout-${min ? 'min' : 'max'}.png'),
          );
        });
      }
    }

    for (final layout in Layout.values) {
      testWidgets('label offset - $layout', (tester) async {
        final sliderStyles = FThemes.zinc.light.sliderStyles;
        final sliderStyle = layout.vertical ? sliderStyles.verticalStyle : sliderStyles.horizontalStyle;

        final positive = layout.vertical ? Alignment.centerLeft : Alignment.topCenter;
        final negative = layout.vertical ? Alignment.centerRight : Alignment.bottomCenter;

        await tester.pumpWidget(
          TestScaffold.app(
            data: FThemes.zinc.light,
            // background: background,
            child: FSlider(
              controller: FContinuousSliderController(
                selection: FSliderSelection(min: 0.30, max: 0.60),
              ),
              layout: layout,
              marks: [
                FSliderMark(
                  value: 0.0,
                  label: const Text('0'),
                  style: sliderStyle.enabledStyle.markStyle.copyWith(
                    labelOffset: 20,
                    labelAnchor: positive,
                  ),
                ),
                FSliderMark(
                  value: 0.25,
                  label: const Text('25'),
                  style: sliderStyle.enabledStyle.markStyle.copyWith(
                    labelOffset: 1,
                    labelAnchor: positive,
                  ),
                ),
                FSliderMark(
                  value: 0.75,
                  label: const Text('75'),
                  style: sliderStyle.enabledStyle.markStyle.copyWith(
                    labelOffset: -1,
                    labelAnchor: negative,
                  ),
                ),
                FSliderMark(
                  value: 1.0,
                  label: const Text('100'),
                  style: sliderStyle.enabledStyle.markStyle.copyWith(
                    labelOffset: -20,
                    labelAnchor: negative,
                  ),
                ),
              ],
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(Thumb).first));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('slider/label-offset-$layout.png'),
        );
      });
    }
  });
}
