@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';
import '../../test_scaffold.dart';

void main() {
  group('FButton', () {
    group('blue screen', () {
      testWidgets('FButtonContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FButton(
                label: const Text('Button'),
                style: TestScaffold.blueScreen.buttonStyles.primary,
                prefix: FIcon(FAssets.icons.circlePlay),
                suffix: FIcon(FAssets.icons.circleStop),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('FButtonIconContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FButton.icon(
                style: TestScaffold.blueScreen.buttonStyles.primary,
                child: FIcon(FAssets.icons.circleStop),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$name enabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  label: const Text('Button'),
                  style: variant,
                  prefix: FIcon(FAssets.icons.circlePlay),
                  suffix: FIcon(FAssets.icons.circleStop),
                  onPress: () {},
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('button/$name/$variant/enabled-content.png'));
        });

        testWidgets('$name enabled and hovered over', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  label: const Text('Button'),
                  style: variant,
                  prefix: FIcon(FAssets.icons.circlePlay),
                  suffix: FIcon(FAssets.icons.circleStop),
                  onPress: () {},
                ),
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.byType(FButton)));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name/$variant/enabled-hovered.png'),
          );
        });

        testWidgets('$name enabled and long pressed', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  label: const Text('Button'),
                  style: variant,
                  prefix: FIcon(FAssets.icons.circlePlay),
                  suffix: FIcon(FAssets.icons.circleStop),
                  onPress: () {},
                ),
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.byType(FButton)));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name/$variant/enabled-long-pressed.png'),
          );
        });

        testWidgets('$name disabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  label: const Text('Button'),
                  style: variant,
                  prefix: FIcon(FAssets.icons.circlePlay),
                  suffix: FIcon(FAssets.icons.circleStop),
                  onPress: null,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('button/$name/$variant/disabled-content.png'));
        });

        testWidgets('$name with enabled raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.raw(
                  style: variant,
                  onPress: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blueAccent,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('button/$name/$variant/enabled-raw.png'));
        });

        testWidgets('$name disabled with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.raw(
                  style: variant,
                  onPress: null,
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blueAccent,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('button/$name/$variant/disabled-raw.png'));
        });

        testWidgets('$name with enabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.icon(
                  onPress: () {},
                  style: variant,
                  child: FIcon(FAssets.icons.chevronRight),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name/$variant/icon-enabled-button.png'),
          );
        });

        testWidgets('$name with disabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.icon(
                  onPress: null,
                  style: variant,
                  child: FIcon(FAssets.icons.chevronRight),
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('button/$name/$variant/icon-disabled.png'));
        });
      }
    }
  });
}