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
                  controller: FContinuousSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.50)),
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
                  selection: FSliderSelection(min: 0.25, max: 0.50),
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
      for (final labelOffset in [-20.0, 20.0]) {
        testWidgets('label offset - $layout - $labelOffset', (tester) async {
          final sliderStyle = FThemes.zinc.light.sliderStyles.enabledHorizontalStyle;
          final style = sliderStyle.markStyle.copyWith(labelOffset: labelOffset);

          await tester.pumpWidget(
            TestScaffold.app(
              data: FThemes.zinc.light,
              // background: background,
              child: FSlider(
                controller: FContinuousSliderController(
                  selection: FSliderSelection(min: 0.25, max: 0.50),
                ),
                layout: layout,
                marks: [
                  FSliderMark(value: 0.0, label: Text('0'), style: style),
                  FSliderMark(value: 0.25, label: Text('25'), style: style, tick: false),
                  FSliderMark(value: 0.5, label: Text('50'), style: style),
                  FSliderMark(value: 0.75, label: Text('75'), style: style, tick: false),
                  FSliderMark(value: 1.0, label: Text('100'), style: style),
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
            matchesGoldenFile('slider/label-offset-$layout-$labelOffset.png'),
          );
        });
      }
    }
  });
}
