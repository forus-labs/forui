@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTile', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FTile)));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                enabled: false,
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('enabled - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTile(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Lorem'),
                subtitle: const Text('Fee, Fo'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/enabled-$name.png'));
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTile(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Lorem'),
                subtitle: const Text('Fee, Fo'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FTile)));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/hovered-$name.png'));
      });

      testWidgets('disabled - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTile(
                enabled: false,
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Lorem'),
                subtitle: const Text('Fee, Fo'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/disabled-$name.png'));
      });
    }

    testWidgets('does not hover', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTile(
              prefixIcon: FIcon(FAssets.icons.bluetooth),
              title: const Text('Bluetooth'),
              details: const Text('FL (5G)'),
              suffixIcon: FIcon(FAssets.icons.chevronRight),
            ),
          ),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FTile)));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/unhoverable.png'));
    });

    testWidgets('no subtitle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTile(
              prefixIcon: FIcon(FAssets.icons.bluetooth),
              title: const Text('Bluetooth'),
              details: const Text('FL (5G)'),
              suffixIcon: FIcon(FAssets.icons.chevronRight),
              onPress: () {},
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/no-subtitle.png'));
    });

    testWidgets('overflowing title', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTile(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('L                                         ong'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/overflowing-title.png'));
    });

    testWidgets('overflowing subtitle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTile(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Title'),
                subtitle: const Text('L                                         ong'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/overflowing-subtitle.png'));
    });

    testWidgets('minimal', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTile(
              title: const Text('Bluetooth'),
              onPress: () {},
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/minimal.png'));
    });
  });
}
