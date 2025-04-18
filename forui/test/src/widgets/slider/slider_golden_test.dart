import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Thumb;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSlider', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSlider(
            style: TestScaffold.blueScreen.sliderStyles.horizontalStyle,
            controller: autoDispose(FContinuousSliderController(selection: FSliderSelection(min: 0.30, max: 0.60))),
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

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      for (final layout in FLayout.values) {
        for (final touch in [true, false]) {
          for (final enabled in [true, false]) {
            testWidgets('${theme.name} - $layout - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
              FTouch.primary = touch;
              final styles = FSliderStyles.inherit(
                colors: theme.data.colors,
                typography: theme.data.typography,
                style: theme.data.style,
              );

              await tester.pumpWidget(
                TestScaffold.app(
                  theme: theme.data,
                  child: FSlider(
                    style: layout.vertical ? styles.verticalStyle : styles.horizontalStyle,
                    label: const Text('Label'),
                    description: const Text('Description'),
                    controller: autoDispose(
                      FContinuousSliderController.range(selection: FSliderSelection(min: 0.30, max: 0.60)),
                    ),
                    layout: layout,
                    enabled: enabled,
                    trackMainAxisExtent: 300,
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
                matchesGoldenFile(
                  'slider/range-slider/${theme.name}/$layout-${touch ? 'touch' : 'desktop'}-${enabled ? 'enabled' : 'disabled'}.png',
                ),
              );
            });
          }

          testWidgets('${theme.name} - $layout - focused', (tester) async {
            FTouch.primary = touch;
            final styles = FSliderStyles.inherit(
              colors: theme.data.colors,
              typography: theme.data.typography,
              style: theme.data.style,
            );

            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FSlider(
                  style: layout.vertical ? styles.verticalStyle : styles.horizontalStyle,
                  label: const Text('Label'),
                  description: const Text('Description'),
                  forceErrorText: 'Error',
                  controller: autoDispose(
                    FContinuousSliderController.range(selection: FSliderSelection(min: 0.30, max: 0.60)),
                  ),
                  layout: layout,
                  trackMainAxisExtent: 300,
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

            Focus.of(tester.element(find.byType(FFocusedOutline).first)).requestFocus();
            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('slider/range-slider/${theme.name}/$layout-${touch ? 'touch' : 'desktop'}-focused.png'),
            );
          });

          testWidgets('${theme.name} - $layout - error', (tester) async {
            FTouch.primary = touch;
            final styles = FSliderStyles.inherit(
              colors: theme.data.colors,
              typography: theme.data.typography,
              style: theme.data.style,
            );

            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FSlider(
                  style: layout.vertical ? styles.verticalStyle : styles.horizontalStyle,
                  label: const Text('Label'),
                  description: const Text('Description'),
                  forceErrorText: 'Error',
                  controller: autoDispose(
                    FContinuousSliderController.range(selection: FSliderSelection(min: 0.30, max: 0.60)),
                  ),
                  layout: layout,
                  trackMainAxisExtent: 300,
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
              matchesGoldenFile('slider/range-slider/${theme.name}/$layout-${touch ? 'touch' : 'desktop'}-error.png'),
            );
          });
        }
      }
    }

    for (final layout in FLayout.values) {
      for (final min in [true, false]) {
        testWidgets('single value - $layout - ${min ? 'min' : 'max'}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FSlider(
                controller: autoDispose(
                  FContinuousSliderController(minExtendable: min, selection: FSliderSelection(min: 0.30, max: 0.60)),
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
            matchesGoldenFile('slider/value-slider/$layout-${min ? 'min' : 'max'}.png'),
          );
        });
      }
    }

    for (final layout in FLayout.values) {
      group('label offset - $layout', () {
        late FSliderStyle sliderStyle;
        late Alignment positive;
        late Alignment negative;
        late List<FSliderMark> marks;

        setUp(() {
          final sliderStyles = FThemes.zinc.light.sliderStyles;
          sliderStyle = layout.vertical ? sliderStyles.verticalStyle : sliderStyles.horizontalStyle;

          positive = layout.vertical ? Alignment.centerLeft : Alignment.topCenter;
          negative = layout.vertical ? Alignment.centerRight : Alignment.bottomCenter;
          marks = [
            FSliderMark(
              value: 0.0,
              label: const Text('0'),
              style: sliderStyle.markStyle.copyWith(labelOffset: 20, labelAnchor: positive),
            ),
            FSliderMark(
              value: 0.25,
              label: const Text('25'),
              style: sliderStyle.markStyle.copyWith(labelOffset: 1, labelAnchor: positive),
            ),
            FSliderMark(
              value: 0.75,
              label: const Text('75'),
              style: sliderStyle.markStyle.copyWith(labelOffset: -1, labelAnchor: negative),
            ),
            FSliderMark(
              value: 1.0,
              label: const Text('100'),
              style: sliderStyle.markStyle.copyWith(labelOffset: -20, labelAnchor: negative),
            ),
          ];
        });

        testWidgets('symmetric padding', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FSlider(
                controller: autoDispose(FContinuousSliderController(selection: FSliderSelection(min: 0.30, max: 0.60))),
                layout: layout,
                marks: marks,
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('slider/label-offset/$layout-symmetric.png'));
        });

        testWidgets('asymmetric cross axis padding - $layout', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FSlider(
                style: sliderStyle.copyWith(
                  childPadding: const EdgeInsets.only(left: 20, top: 40, right: 10, bottom: 30),
                ),
                controller: autoDispose(FContinuousSliderController(selection: FSliderSelection(min: 0.30, max: 0.60))),
                layout: layout,
                marks: marks,
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('slider/label-offset/$layout-asymmetric.png'));
        });

        testWidgets('labelled', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FSlider(
                label: const Text('Label'),
                description: const Text('Description'),
                trackMainAxisExtent: 300,
                controller: autoDispose(FContinuousSliderController(selection: FSliderSelection(min: 0.30, max: 0.60))),
                layout: layout,
                marks: marks,
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('slider/label-offset/$layout-labelled.png'));
        });
      });
    }

    testWidgets('interweaving marks with no labels', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSlider(
            controller: autoDispose(FContinuousSliderController(selection: FSliderSelection(min: 0.30, max: 0.60))),
            marks: const [
              FSliderMark(value: 0, label: Text('0%')),
              FSliderMark(value: 0.25, tick: false),
              FSliderMark(value: 0.5, label: Text('50%')),
              FSliderMark(value: 0.75, tick: false),
              FSliderMark(value: 1, label: Text('100%')),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('slider/interweaving-marks.png'));
    });
  });

  tearDown(() => FTouch.primary = null);
}
