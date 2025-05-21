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
              autofocus: true,
              style: TestScaffold.blueScreen.buttonStyles.primary,
              prefix: const Icon(FIcons.circlePlay),
              suffix: const Icon(FIcons.circleStop),
              onPress: () {},
              child: const Text('Button'),
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
              child: const Icon(FIcons.circleStop),
              onPress: () {},
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final theme in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('${theme.name} enabled with FButtonContent', (
          tester,
        ) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                style: variant,
                prefix: const Icon(FIcons.circlePlay),
                suffix: const Icon(FIcons.circleStop),
                onPress: () {},
                child: const Text('Button'),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/enabled-content.png',
            ),
          );
        });

        testWidgets('${theme.name} with intrinsic width', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                style: variant,
                intrinsicWidth: true,
                prefix: const Icon(FIcons.circlePlay),
                suffix: const Icon(FIcons.circleStop),
                onPress: () {},
                child: const Text('Button'),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/intrinsic-width.png',
            ),
          );
        });

        testWidgets('${theme.name} enabled and hovered over', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                style: variant,
                prefix: const Icon(FIcons.circlePlay),
                suffix: const Icon(FIcons.circleStop),
                onPress: () {},
                child: const Text('Button'),
              ),
            ),
          );

          final gesture = await tester.createGesture(
            kind: PointerDeviceKind.mouse,
          );
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.byType(FButton)));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/enabled-hovered.png',
            ),
          );
        });

        testWidgets('${theme.name} enabled and long pressed', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                style: variant,
                prefix: const Icon(FIcons.circlePlay),
                suffix: const Icon(FIcons.circleStop),
                onPress: () {},
                child: const Text('Button'),
              ),
            ),
          );

          final gesture = await tester.createGesture(
            kind: PointerDeviceKind.mouse,
          );
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.byType(FButton)));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/enabled-long-pressed.png',
            ),
          );
        });

        testWidgets('${theme.name} focused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                autofocus: true,
                style: variant,
                prefix: const Icon(FIcons.circlePlay),
                suffix: const Icon(FIcons.circleStop),
                onPress: () {},
                child: const Text('Button'),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/${theme.name}/$variant/focused.png'),
          );
        });

        testWidgets('${theme.name} disabled with FButtonContent', (
          tester,
        ) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                style: variant,
                prefix: const Icon(FIcons.circlePlay),
                suffix: const Icon(FIcons.circleStop),
                onPress: null,
                child: const Text('Button'),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/disabled-content.png',
            ),
          );
        });

        testWidgets('${theme.name} with enabled raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
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
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/${theme.name}/$variant/enabled-raw.png'),
          );
        });

        testWidgets('${theme.name} disabled with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
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
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/${theme.name}/$variant/disabled-raw.png'),
          );
        });

        testWidgets('${theme.name} with enabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton.icon(
                onPress: () {},
                style: variant,
                child: const Icon(FIcons.chevronRight),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/icon-enabled-button.png',
            ),
          );
        });

        testWidgets('${theme.name} with disabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton.icon(
                onPress: null,
                style: variant,
                child: const Icon(FIcons.chevronRight),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/icon-disabled.png',
            ),
          );
        });

        testWidgets('${theme.name} with enabled circular progress', (
          tester,
        ) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                prefix: const FProgress.circularIcon(),
                onPress: () {},
                style: variant,
                child: const Text('Loading'),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/circular-progress-enabled-button.png',
            ),
          );
        });

        testWidgets('${theme.name} with disabled circular progress', (
          tester,
        ) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                prefix: const FProgress.circularIcon(),
                onPress: null,
                style: variant,
                child: const Text('Loading'),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/${theme.name}/$variant/circular-progress-disabled-button.png',
            ),
          );
        });
      }
    }
  });
}
