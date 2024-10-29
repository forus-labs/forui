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
            child: FButton(
              label: const Text('Button'),
              style: TestScaffold.blueScreen.buttonStyles.primary,
              prefix: FIcon(FAssets.icons.circlePlay),
              suffix: FIcon(FAssets.icons.circleStop),
              onPress: () {},
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('FButtonIconContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FButton.icon(
              style: TestScaffold.blueScreen.buttonStyles.primary,
              child: FIcon(FAssets.icons.circleStop),
              onPress: () {},
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$themeName enabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton(
                label: const Text('Button'),
                style: variant,
                prefix: FIcon(FAssets.icons.circlePlay),
                suffix: FIcon(FAssets.icons.circleStop),
                onPress: () {},
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/enabled-content.png'),
          );
        });

        testWidgets('$themeName enabled and hovered over', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton(
                label: const Text('Button'),
                style: variant,
                prefix: FIcon(FAssets.icons.circlePlay),
                suffix: FIcon(FAssets.icons.circleStop),
                onPress: () {},
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
            matchesGoldenFile('button/$themeName/$variant/enabled-hovered.png'),
          );
        });

        testWidgets('$themeName enabled and long pressed', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton(
                label: const Text('Button'),
                style: variant,
                prefix: FIcon(FAssets.icons.circlePlay),
                suffix: FIcon(FAssets.icons.circleStop),
                onPress: () {},
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
            matchesGoldenFile('button/$themeName/$variant/enabled-long-pressed.png'),
          );
        });

        testWidgets('$themeName disabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton(
                label: const Text('Button'),
                style: variant,
                prefix: FIcon(FAssets.icons.circlePlay),
                suffix: FIcon(FAssets.icons.circleStop),
                onPress: null,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/disabled-content.png'),
          );
        });

        testWidgets('$themeName with enabled raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
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
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('button/$themeName/$variant/enabled-raw.png'));
        });

        testWidgets('$themeName disabled with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
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
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/disabled-raw.png'),
          );
        });

        testWidgets('$themeName with enabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton.icon(
                onPress: () {},
                style: variant,
                child: FIcon(FAssets.icons.chevronRight),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/icon-enabled-button.png'),
          );
        });

        testWidgets('$themeName with disabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton.icon(
                onPress: null,
                style: variant,
                child: FIcon(FAssets.icons.chevronRight),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/icon-disabled.png'),
          );
        });
      }
    }
  });
}
